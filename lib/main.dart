import 'package:flutter/material.dart';
import 'package:restoapp/app.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/config/api_config.dart';
import 'package:restoapp/core/utils/logger/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Log app start
  AppLogger.info('🚀 RestoApp Starting...', tag: 'APP');

  // Initialize dependency injection
  AppLogger.info('Initializing dependencies...', tag: 'APP');
  await configureDependencies();
  AppLogger.info('Dependencies initialized ✅', tag: 'APP');

  // Print API configuration for debugging
  ApiConfig.printConfig();

  // Log app ready
  AppLogger.info('App ready to run ✅', tag: 'APP');

  runApp(const RestoApp());
}
