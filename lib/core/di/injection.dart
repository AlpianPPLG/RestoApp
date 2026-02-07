import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/di/injection.config.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Configure all injectable dependencies.
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
