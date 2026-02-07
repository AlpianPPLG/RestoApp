# 🚀 RestoApp - Quick Start Guide

Panduan cepat untuk memulai development aplikasi RestoApp Flutter.

---

## 📋 Prerequisites

### Development Tools

| Tool | Version | Download |
|------|---------|----------|
| Flutter SDK | 3.19+ | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | 3.3+ | (Included with Flutter) |
| Android Studio | Latest | [developer.android.com](https://developer.android.com/studio) |
| VS Code (Optional) | Latest | [code.visualstudio.com](https://code.visualstudio.com/) |
| Xcode (macOS only) | 15+ | App Store |

### Backend Requirements

| Component | Version | Notes |
|-----------|---------|-------|
| MySQL Server | 8.0+ | Database server |
| Web App Server | Running | RESTAUS web app untuk API |

---

## 🛠️ Installation Steps

### Step 1: Install Flutter

```bash
# Windows (using Chocolatey)
choco install flutter

# macOS (using Homebrew)
brew install flutter

# Linux (Manual)
# Download from flutter.dev and add to PATH

# Verify installation
flutter doctor
```

### Step 2: Create Project

```bash
# Create new Flutter project
flutter create restoapp

# Navigate to project
cd restoapp
```

### Step 3: Configure pubspec.yaml

```yaml
name: restoapp
description: Restaurant POS & Management System
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.4
  equatable: ^2.0.5
  
  # Dependency Injection
  get_it: ^7.6.7
  injectable: ^2.3.2
  
  # Routing
  go_router: ^13.2.0
  
  # Networking
  dio: ^5.4.0
  connectivity_plus: ^5.0.2
  
  # Local Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # UI Components
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  
  # Charts
  fl_chart: ^0.66.2
  
  # PDF & Printing
  pdf: ^3.10.7
  printing: ^5.12.0
  
  # Utilities
  intl: ^0.18.1
  logger: ^2.0.2
  lucide_icons: ^0.257.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  injectable_generator: ^2.4.1

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
```

### Step 4: Install Dependencies

```bash
flutter pub get
```

### Step 5: Create Folder Structure

```bash
# Create main folders
mkdir -p lib/core/{config,constants,di,error,network,router,theme,utils}
mkdir -p lib/data/{datasources/{local,remote},models,repositories}
mkdir -p lib/domain/{entities,repositories,usecases}
mkdir -p lib/presentation/{blocs,pages,widgets}
mkdir -p assets/{images,icons,fonts}
mkdir -p test/{unit,widget,integration}
```

### Step 6: Configure API

Buat file `lib/core/config/api_config.dart`:

```dart
class ApiConfig {
  // Development
  static const String devBaseUrl = 'http://10.0.2.2:3000/api'; // Android emulator
  // static const String devBaseUrl = 'http://localhost:3000/api'; // iOS simulator
  
  // Production
  static const String prodBaseUrl = 'https://your-server.com/api';
  
  // Current environment
  static const bool isProduction = false;
  
  static String get baseUrl => isProduction ? prodBaseUrl : devBaseUrl;
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
```

### Step 7: Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 8: Run Application

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d <device_id>

# Run in debug mode with hot reload
flutter run --debug

# Run in release mode
flutter run --release
```

---

## 📱 Running on Devices

### Android Emulator

1. Open Android Studio
2. Go to **Tools > AVD Manager**
3. Create Virtual Device (Pixel 4, API 33 recommended)
4. Start emulator
5. Run `flutter run`

### iOS Simulator (macOS only)

1. Open Xcode
2. Go to **Xcode > Open Developer Tool > Simulator**
3. Choose device (iPhone 14 recommended)
4. Run `flutter run`

### Physical Device

**Android:**
1. Enable Developer Options on device
2. Enable USB Debugging
3. Connect via USB
4. Run `flutter run`

**iOS:**
1. Connect device via USB
2. Trust computer on device
3. Open Xcode, configure signing
4. Run `flutter run`

---

## 🗄️ Database Setup

### Ensure MySQL is Running

```bash
# Check MySQL status
mysql --version

# Connect to MySQL
mysql -u root -p
```

### Verify Database Exists

```sql
-- Check if database exists
SHOW DATABASES LIKE 'restaus_db';

-- If not, run the web app's schema
SOURCE /path/to/restaus-app/sql/query.sql;

-- Seed data (optional)
SOURCE /path/to/restaus-app/sql/seed.sql;
```

### Test API Connection

Pastikan web app server berjalan:

```bash
# Check if API is accessible
curl http://localhost:3000/api/menus

# Expected response:
# {"success":true,"data":[...]}
```

---

## 🔧 Development Workflow

### Daily Development

```bash
# 1. Pull latest changes
git pull

# 2. Get dependencies
flutter pub get

# 3. Run code generation (if models changed)
dart run build_runner build

# 4. Run app
flutter run

# 5. Hot reload on changes
# Press 'r' in terminal or save file
```

### Code Generation (when needed)

```bash
# One-time build
dart run build_runner build

# Watch mode (auto-regenerate)
dart run build_runner watch

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/auth_bloc_test.dart

# Run with coverage
flutter test --coverage
```

### Building for Release

```bash
# Android APK
flutter build apk

# Android App Bundle (Play Store)
flutter build appbundle

# iOS (macOS only)
flutter build ios
```

---

## 📁 First Files to Create

### 1. main.dart

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await configureDependencies();
  
  runApp(const RestoApp());
}
```

### 2. app.dart

```dart
// lib/app.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class RestoApp extends StatelessWidget {
  const RestoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RestoApp',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

### 3. App Theme

```dart
// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}
```

### 4. App Colors

```dart
// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary (Orange)
  static const primary = Color(0xFFF97316);
  static const primaryDark = Color(0xFFEA580C);
  static const primaryLight = Color(0xFFFB923C);
  
  // Status Colors
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFEAB308);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
  
  // Table Status
  static const tableAvailable = Color(0xFF22C55E);
  static const tableOccupied = Color(0xFF3B82F6);
  static const tableReserved = Color(0xFFEAB308);
  static const tableWarning = Color(0xFFEF4444);
  
  // Neutrals
  static const background = Color(0xFFFFF7ED);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
}
```

---

## 🔍 Troubleshooting

### Common Issues

**1. Flutter doctor warnings**
```bash
flutter doctor -v
# Follow the suggestions to resolve issues
```

**2. Dependency conflicts**
```bash
flutter clean
flutter pub get
```

**3. Code generation errors**
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

**4. Emulator not detected**
```bash
flutter devices
# Make sure emulator is running
adb devices  # For Android
```

**5. API connection refused (Android)**
- Use `10.0.2.2` instead of `localhost` for Android emulator
- Ensure backend server is running
- Check firewall settings

**6. iOS build fails (macOS)**
```bash
cd ios
pod install --repo-update
cd ..
flutter clean
flutter run
```

---

## 📚 Useful Commands

```bash
# Flutter info
flutter --version
flutter doctor

# Project management
flutter create project_name
flutter clean
flutter pub get
flutter pub upgrade

# Run & build
flutter run
flutter run --release
flutter build apk
flutter build ios

# Testing
flutter test
flutter analyze

# Code generation
dart run build_runner build
dart run build_runner watch

# Device management
flutter devices
flutter emulators
flutter emulators --launch <emulator_id>
```

---

## 📖 Next Steps

1. ✅ Complete project setup
2. 📝 Review [PlanningApp.md](./PlanningApp.md) for full architecture
3. 📋 Check [major-task.md](./major-task.md) for development tasks
4. 🚀 Start with Authentication module
5. 📊 Track progress in [PROGRESS.md](./PROGRESS.md)

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [BLoC Library](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Material Design 3](https://m3.material.io/)

---

*Last Updated: February 7, 2026*
