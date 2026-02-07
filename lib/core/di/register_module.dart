import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'package:restoapp/core/network/api_client.dart';
import 'package:restoapp/core/network/network_info.dart';

/// Module for registering third-party dependencies.
@module
abstract class RegisterModule {
  @singleton
  Logger get logger => Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  Connectivity get connectivity => Connectivity();

  @singleton
  ApiClient apiClient(FlutterSecureStorage secureStorage) =>
      ApiClient(secureStorage: secureStorage);

  @singleton
  Dio dio(ApiClient apiClient) => apiClient.dio;

  @singleton
  NetworkInfo networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity: connectivity);
}
