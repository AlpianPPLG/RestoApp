import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:restoapp/core/config/api_config.dart';
import 'package:restoapp/core/constants/app_constants.dart';
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/core/utils/logger/app_logger.dart';

/// Configured Dio HTTP client with interceptors.
class ApiClient {
  late final Dio dio;
  final FlutterSecureStorage _secureStorage;

  ApiClient({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage() {
    AppLogger.info('Initializing API Client', tag: 'API');
    AppLogger.info('Base URL: ${ApiConfig.baseUrl}', tag: 'API');

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      _authInterceptor(),
      _loggingInterceptor(),
      _errorInterceptor(),
    ]);
  }

  /// Authentication interceptor: attaches token to requests.
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _secureStorage.read(key: AppConstants.authTokenKey);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired - clear storage
          await _secureStorage.delete(key: AppConstants.authTokenKey);
        }
        handler.next(error);
      },
    );
  }

  /// Logging interceptor: logs request/response details.
  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        AppLogger.apiRequest(
          options.method,
          options.uri.toString(),
          data: options.data,
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger.apiResponse(
          response.requestOptions.method,
          response.requestOptions.uri.toString(),
          response.statusCode ?? 0,
        );
        handler.next(response);
      },
      onError: (error, handler) {
        AppLogger.apiError(
          error.requestOptions.method,
          error.requestOptions.uri.toString(),
          error.message,
        );
        handler.next(error);
      },
    );
  }

  /// Error interceptor: transforms Dio errors to app exceptions.
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: const NetworkException(
                  message: 'Koneksi timeout, coba lagi',
                ),
              ),
            );
            break;
          case DioExceptionType.connectionError:
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: const NetworkException(),
              ),
            );
            break;
          case DioExceptionType.badResponse:
            final statusCode = error.response?.statusCode;
            final responseData = error.response?.data;
            final message = responseData is Map
                ? (responseData['message'] ??
                      responseData['error'] ??
                      'Server error')
                : 'Server error';

            switch (statusCode) {
              case 401:
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: AuthException(message: message.toString()),
                  ),
                );
                break;
              case 403:
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: UnauthorizedException(message: message.toString()),
                  ),
                );
                break;
              case 404:
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: NotFoundException(message: message.toString()),
                  ),
                );
                break;
              case 422:
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: ValidationException(message: message.toString()),
                  ),
                );
                break;
              default:
                handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: ServerException(
                      message: message.toString(),
                      statusCode: statusCode,
                    ),
                  ),
                );
            }
            break;
          case DioExceptionType.unknown:
            // Unknown errors (server not running, DNS failure, etc.)
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: NetworkException(
                  message:
                      error.error?.toString() ??
                      'Tidak dapat terhubung ke server. Pastikan backend sudah berjalan.',
                ),
              ),
            );
            break;
          default:
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: NetworkException(
                  message: error.message ?? 'Terjadi kesalahan jaringan',
                ),
              ),
            );
        }
      },
    );
  }
}
