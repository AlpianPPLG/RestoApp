// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:restoapp/core/di/register_module.dart' as _i1003;
import 'package:restoapp/core/network/api_client.dart' as _i305;
import 'package:restoapp/core/network/network_info.dart' as _i637;
import 'package:restoapp/data/datasources/remote/auth_remote_datasource.dart'
    as _i128;
import 'package:restoapp/data/datasources/remote/menu_remote_datasource.dart'
    as _i642;
import 'package:restoapp/data/datasources/remote/order_remote_datasource.dart'
    as _i279;
import 'package:restoapp/data/datasources/remote/payment_remote_datasource.dart'
    as _i919;
import 'package:restoapp/data/datasources/remote/table_remote_datasource.dart'
    as _i147;
import 'package:restoapp/data/datasources/remote/user_remote_datasource.dart'
    as _i620;
import 'package:restoapp/data/repositories/auth_repository_impl.dart' as _i331;
import 'package:restoapp/data/repositories/menu_repository_impl.dart' as _i783;
import 'package:restoapp/data/repositories/order_repository_impl.dart' as _i936;
import 'package:restoapp/data/repositories/payment_repository_impl.dart'
    as _i384;
import 'package:restoapp/data/repositories/table_repository_impl.dart' as _i2;
import 'package:restoapp/data/repositories/user_repository_impl.dart' as _i120;
import 'package:restoapp/domain/repositories/auth_repository.dart' as _i408;
import 'package:restoapp/domain/repositories/menu_repository.dart' as _i759;
import 'package:restoapp/domain/repositories/order_repository.dart' as _i912;
import 'package:restoapp/domain/repositories/payment_repository.dart' as _i740;
import 'package:restoapp/domain/repositories/table_repository.dart' as _i404;
import 'package:restoapp/domain/repositories/user_repository.dart' as _i542;
import 'package:restoapp/domain/usecases/auth/get_current_user_usecase.dart'
    as _i352;
import 'package:restoapp/domain/usecases/auth/login_usecase.dart' as _i838;
import 'package:restoapp/domain/usecases/auth/logout_usecase.dart' as _i984;
import 'package:restoapp/domain/usecases/auth/register_usecase.dart' as _i551;
import 'package:restoapp/presentation/blocs/admin/admin_bloc.dart' as _i881;
import 'package:restoapp/presentation/blocs/auth/auth_bloc.dart' as _i981;
import 'package:restoapp/presentation/blocs/menu/menu_bloc.dart' as _i300;
import 'package:restoapp/presentation/blocs/table/table_bloc.dart' as _i782;
import 'package:restoapp/presentation/blocs/user/user_bloc.dart' as _i750;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i974.Logger>(() => registerModule.logger);
    gh.singleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.singleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.singleton<_i637.NetworkInfo>(
      () => registerModule.networkInfo(gh<_i895.Connectivity>()),
    );
    gh.singleton<_i305.ApiClient>(
      () => registerModule.apiClient(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio(gh<_i305.ApiClient>()));
    gh.factory<_i128.AuthRemoteDataSource>(
      () => _i128.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i642.MenuRemoteDataSource>(
      () => _i642.MenuRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i279.OrderRemoteDataSource>(
      () => _i279.OrderRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i919.PaymentRemoteDataSource>(
      () => _i919.PaymentRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i147.TableRemoteDataSource>(
      () => _i147.TableRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i620.UserRemoteDataSource>(
      () => _i620.UserRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i408.AuthRepository>(
      () => _i331.AuthRepositoryImpl(
        gh<_i128.AuthRemoteDataSource>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i352.GetCurrentUserUseCase>(
      () => _i352.GetCurrentUserUseCase(gh<_i408.AuthRepository>()),
    );
    gh.factory<_i838.LoginUseCase>(
      () => _i838.LoginUseCase(gh<_i408.AuthRepository>()),
    );
    gh.factory<_i984.LogoutUseCase>(
      () => _i984.LogoutUseCase(gh<_i408.AuthRepository>()),
    );
    gh.factory<_i551.RegisterUseCase>(
      () => _i551.RegisterUseCase(gh<_i408.AuthRepository>()),
    );
    gh.factory<_i759.MenuRepository>(
      () => _i783.MenuRepositoryImpl(gh<_i642.MenuRemoteDataSource>()),
    );
    gh.factory<_i542.UserRepository>(
      () => _i120.UserRepositoryImpl(gh<_i620.UserRemoteDataSource>()),
    );
    gh.factory<_i750.UserBloc>(
      () => _i750.UserBloc(gh<_i542.UserRepository>()),
    );
    gh.factory<_i404.TableRepository>(
      () => _i2.TableRepositoryImpl(gh<_i147.TableRemoteDataSource>()),
    );
    gh.factory<_i912.OrderRepository>(
      () => _i936.OrderRepositoryImpl(gh<_i279.OrderRemoteDataSource>()),
    );
    gh.factory<_i981.AuthBloc>(
      () => _i981.AuthBloc(
        gh<_i838.LoginUseCase>(),
        gh<_i984.LogoutUseCase>(),
        gh<_i551.RegisterUseCase>(),
        gh<_i352.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i300.MenuBloc>(
      () => _i300.MenuBloc(gh<_i759.MenuRepository>()),
    );
    gh.factory<_i740.PaymentRepository>(
      () => _i384.PaymentRepositoryImpl(gh<_i919.PaymentRemoteDataSource>()),
    );
    gh.factory<_i881.AdminBloc>(
      () => _i881.AdminBloc(
        gh<_i759.MenuRepository>(),
        gh<_i404.TableRepository>(),
        gh<_i912.OrderRepository>(),
      ),
    );
    gh.factory<_i782.TableBloc>(
      () => _i782.TableBloc(gh<_i404.TableRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i1003.RegisterModule {}
