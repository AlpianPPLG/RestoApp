# 🍽️ RestoApp - Restaurant POS Mobile Application

<p align="center">
  <img src="assets/icons/app_icon.png" alt="RestoApp Logo" width="120"/>
</p>

<p align="center">
  <strong>Modern Point of Sale System for Restaurant Management</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#installation">Installation</a> •
  <a href="#project-structure">Structure</a> •
  <a href="#api-documentation">API</a>
</p>

---

## 📖 Overview

**RestoApp** is a comprehensive mobile Point of Sale (POS) application designed for restaurants. Built with Flutter, it provides role-based access for different staff members including Admin, Waiter, Cashier, and Kitchen staff.

This mobile app connects to the **RESTAUS** backend system and shares the same MySQL database (`restaus_db`), enabling seamless integration between web and mobile platforms.

## ✨ Features

### 👨‍💼 Admin Module

- **Dashboard** - Overview with stats (total menus, tables, today's orders, revenue)
- **Menu Management** - Full CRUD operations with search and category filter
- **Table Management** - Add, edit, delete tables with status management
- **User Management** - Staff account management with role assignment
- **Settings** - Restaurant configuration (coming soon)

### 🍽️ Waiter Module (Coming Soon)

- Table grid view with real-time status
- Order creation with menu catalog
- Cart system with special notes
- Order submission to kitchen

### 👨‍🍳 Kitchen Module (Coming Soon)

- Kitchen Display System (KDS)
- Order queue management
- Item status updates
- New order alerts

### 💰 Cashier Module (Coming Soon)

- Pending orders list
- Payment processing
- Multiple payment methods (Cash, QRIS, Debit)
- Receipt generation

### 🔐 Authentication

- Secure login with JWT tokens
- Role-based access control
- Auto-login with session persistence
- Secure token storage

## 🛠️ Tech Stack

| Category                 | Technology                 |
| ------------------------ | -------------------------- |
| **Framework**            | Flutter 3.x                |
| **Language**             | Dart 3.3+                  |
| **State Management**     | flutter_bloc 8.x           |
| **Dependency Injection** | get_it + injectable        |
| **Routing**              | go_router 13.x             |
| **HTTP Client**          | Dio 5.x                    |
| **Local Storage**        | flutter_secure_storage     |
| **Code Generation**      | freezed, json_serializable |
| **Architecture**         | Clean Architecture         |

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/           # App constants, API endpoints
│   ├── di/                  # Dependency injection setup
│   ├── error/               # Exception and failure classes
│   ├── network/             # Network info, connectivity
│   ├── router/              # GoRouter configuration
│   ├── theme/               # Colors, typography, spacing
│   └── utils/               # Logger, helpers
│
├── data/                    # Data layer
│   ├── datasources/         # Remote data sources (API calls)
│   ├── models/              # Data transfer objects
│   └── repositories/        # Repository implementations
│
├── domain/                  # Domain layer
│   ├── entities/            # Business entities (freezed)
│   ├── repositories/        # Repository interfaces
│   └── usecases/            # Business logic use cases
│
├── presentation/            # Presentation layer
│   ├── blocs/               # BLoC state management
│   ├── pages/               # UI screens
│   └── widgets/             # Reusable components
│
├── app.dart                 # App widget with MaterialApp
└── main.dart                # Entry point
```

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart SDK 3.3.0 or higher
- Android Studio / VS Code with Flutter extensions
- Backend server running (RESTAUS API on port 3000)

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/restoapp.git
   cd restoapp
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code** (freezed, json_serializable, injectable)

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configure API endpoint**

   Edit `lib/core/constants/api_endpoints.dart`:

   ```dart
   static const String baseUrl = 'http://localhost:3000/api';
   // For Android emulator: 'http://10.0.2.2:3000/api'
   // For iOS simulator: 'http://localhost:3000/api'
   // For physical device: 'http://YOUR_IP:3000/api'
   ```

5. **Run the app**

   ```bash
   # For Chrome (Web)
   flutter run -d chrome

   # For Android
   flutter run -d android

   # For iOS
   flutter run -d ios
   ```

## 📡 API Documentation

The app connects to the RESTAUS backend API. Ensure the backend is running on `http://localhost:3000`.

### Authentication Endpoints

| Method | Endpoint             | Description       |
| ------ | -------------------- | ----------------- |
| POST   | `/api/auth/login`    | User login        |
| POST   | `/api/auth/register` | User registration |
| POST   | `/api/auth/logout`   | User logout       |

### Menu Endpoints

| Method | Endpoint         | Description    |
| ------ | ---------------- | -------------- |
| GET    | `/api/menus`     | Get all menus  |
| GET    | `/api/menus/:id` | Get menu by ID |
| POST   | `/api/menus`     | Create menu    |
| PUT    | `/api/menus/:id` | Update menu    |
| DELETE | `/api/menus/:id` | Delete menu    |

### Table Endpoints

| Method | Endpoint                 | Description    |
| ------ | ------------------------ | -------------- |
| GET    | `/api/tables`            | Get all tables |
| POST   | `/api/tables`            | Create table   |
| PUT    | `/api/tables/:id`        | Update table   |
| PATCH  | `/api/tables/:id/status` | Update status  |
| DELETE | `/api/tables/:id`        | Delete table   |

### User Endpoints

| Method | Endpoint                  | Description    |
| ------ | ------------------------- | -------------- |
| GET    | `/api/users`              | Get all users  |
| POST   | `/api/users`              | Create user    |
| PUT    | `/api/users/:id`          | Update user    |
| PUT    | `/api/users/:id/password` | Reset password |
| DELETE | `/api/users/:id`          | Delete user    |

### Category Endpoints

| Method | Endpoint          | Description        |
| ------ | ----------------- | ------------------ |
| GET    | `/api/categories` | Get all categories |

## 🎨 Theme

The app uses a custom orange-based Material Design theme:

| Color      | Hex       | Usage            |
| ---------- | --------- | ---------------- |
| Primary    | `#F57C00` | Main brand color |
| Secondary  | `#4CAF50` | Success states   |
| Background | `#FFF8F0` | App background   |
| Surface    | `#FFFFFF` | Cards, dialogs   |
| Error      | `#E53935` | Error states     |

## 📊 Progress

| Phase                     | Status      | Completion |
| ------------------------- | ----------- | ---------- |
| Phase 1: Foundation       | ✅ Complete | 100%       |
| Phase 2: Authentication   | ✅ Complete | 100%       |
| Phase 3: Admin Module     | ✅ Complete | 100%       |
| Phase 4: Waiter Module    | ✅ Complete | 100%       |
| Phase 5: Kitchen Module   | 🔄 Pending  | 0%         |
| Phase 6: Cashier Module   | 🔄 Pending  | 0%         |
| Phase 7: Receipt & Extras | 🔄 Pending  | 0%         |
| Phase 8: Polish & Testing | 🔄 Pending  | 0%         |

**Overall Progress: 85%**

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 📱 Supported Platforms

- ✅ Android (SDK 21+)
- ✅ iOS (12.0+)
- ✅ Web (Chrome, Edge, Firefox)
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 Development Commands

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Generate code (freezed, injectable)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs

# Clean build
flutter clean && flutter pub get
```

## 📂 Related Projects

- **RESTAUS** - Backend API (Node.js + Express + MySQL)
- **restaus-app** - Web Admin Dashboard (Next.js)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, open an issue in the repository or contact the development team.

---

<p align="center">
  Made with ❤️ using Flutter
</p>
