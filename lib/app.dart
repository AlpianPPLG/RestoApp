import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/theme/app_theme.dart';
import 'package:restoapp/core/router/app_router.dart';
import 'package:restoapp/presentation/blocs/auth/auth_bloc.dart';

/// Root widget of the RestoApp application.
class RestoApp extends StatelessWidget {
  const RestoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp.router(
        title: 'RestoApp',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
