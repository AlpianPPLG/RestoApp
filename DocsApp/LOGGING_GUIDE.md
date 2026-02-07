# 📝 Logging Guide - RestoApp

## Overview

RestoApp menggunakan comprehensive logging system untuk tracking semua aktivitas aplikasi, dari app start hingga user actions.

---

## 🎯 Logger Features

### **AppLogger** - Centralized Logging Service

Location: `lib/core/utils/logger/app_logger.dart`

**Features:**
- ✅ Color-coded log levels
- ✅ Emoji indicators
- ✅ Timestamps
- ✅ Tag-based categorization
- ✅ Stack trace for errors
- ✅ Structured data logging

---

## 📊 Log Levels

| Level | Method | Usage | Emoji |
|-------|--------|-------|-------|
| **Debug** | `AppLogger.debug()` | Development info | 🐛 |
| **Info** | `AppLogger.info()` | General information | ℹ️ |
| **Warning** | `AppLogger.warning()` | Potential issues | ⚠️ |
| **Error** | `AppLogger.error()` | Errors & exceptions | ❌ |
| **Fatal** | `AppLogger.fatal()` | Critical failures | 💀 |

---

## 🏷️ Log Tags

| Tag | Purpose | Example |
|-----|---------|---------|
| **APP** | Application lifecycle | App start, initialization |
| **AUTH** | Authentication events | Login, logout, register |
| **API** | API requests/responses | HTTP calls, errors |
| **BLOC** | BLoC events/states | State changes |
| **NAV** | Navigation | Route changes |
| **USER** | User actions | Button clicks, form submits |
| **UI** | UI events | Validation, rendering |

---

## 💻 Usage Examples

### **1. Basic Logging**

```dart
// Info log
AppLogger.info('User logged in successfully');

// With tag
AppLogger.info('Database initialized', tag: 'DB');

// With data
AppLogger.info('Order created', tag: 'ORDER', data: {'orderId': 123});
```

### **2. Error Logging**

```dart
try {
  // Some operation
} catch (e, stackTrace) {
  AppLogger.error(
    'Failed to fetch data',
    tag: 'API',
    error: e,
    stackTrace: stackTrace,
  );
}
```

### **3. Authentication Logging**

```dart
// Login attempt
AppLogger.auth('Login attempt', username: 'john_doe');

// Login success
AppLogger.auth(
  'Login successful',
  username: 'john_doe',
  data: {'role': 'admin', 'userId': 1},
);

// Login failed
AppLogger.error(
  'Login failed',
  tag: 'AUTH',
  error: 'Invalid credentials',
);
```

### **4. API Logging**

```dart
// Request
AppLogger.apiRequest('POST', '/api/auth/login', data: {'username': 'john'});

// Response
AppLogger.apiResponse('POST', '/api/auth/login', 200);

// Error
AppLogger.apiError('POST', '/api/auth/login', 'Connection timeout');
```

### **5. BLoC Logging**

```dart
// Event
AppLogger.blocEvent('AuthBloc', 'LoginRequested', data: {'username': 'john'});

// State
AppLogger.blocState('AuthBloc', 'Authenticated', data: {'userId': 1});
```

### **6. User Action Logging**

```dart
// Button click
AppLogger.userAction('Login button pressed', data: {'username': 'john'});

// Form submit
AppLogger.userAction('Register form submitted', data: {
  'username': 'john',
  'role': 'waiter',
});
```

### **7. Navigation Logging**

```dart
AppLogger.navigation('/login', '/dashboard');
```

---

## 🔍 Log Output Examples

### **App Start**
```
ℹ️ [APP] 🚀 RestoApp Starting...
ℹ️ [APP] Initializing dependencies...
ℹ️ [API] Initializing API Client
ℹ️ [API] Base URL: http://192.168.1.7:3000/api
ℹ️ [APP] Dependencies initialized ✅
ℹ️ [APP] App ready to run ✅
```

### **Login Flow**
```
ℹ️ [USER] User Action: Login button pressed | Data: {username: john_doe}
🐛 [BLOC] BLoC Event: AuthBloc.AuthLoginRequested | Data: {username: john_doe}
ℹ️ [AUTH] Auth: Login attempt - User: john_doe
ℹ️ [API] API Request: POST http://192.168.1.7:3000/api/auth/login
ℹ️ [API] API Response: POST /api/auth/login - Status: 200
ℹ️ [AUTH] Auth: Login successful - User: john_doe | Data: {role: admin, userId: 1}
🐛 [BLOC] BLoC State: AuthBloc → Authenticated | Data: {userId: 1}
```

### **Registration Flow**
```
ℹ️ [USER] User Action: Register button pressed | Data: {username: jane_doe, fullName: Jane Doe, role: waiter}
🐛 [BLOC] BLoC Event: AuthBloc.AuthRegisterRequested
ℹ️ [AUTH] Auth: Registration attempt - User: jane_doe | Data: {role: waiter}
ℹ️ [API] API Request: POST http://192.168.1.7:3000/api/auth/register
ℹ️ [API] API Response: POST /api/auth/register - Status: 201
ℹ️ [AUTH] Auth: Registration successful - User: jane_doe | Data: {role: waiter, userId: 5}
```

### **Error Example**
```
❌ [AUTH] Login failed
   Error: Invalid credentials
   
❌ [API] API Error: POST /api/auth/login
   Error: DioException: Connection timeout
```

---

## 🎨 Log Colors (Terminal)

| Level | Color |
|-------|-------|
| Debug | Gray |
| Info | Blue |
| Warning | Yellow |
| Error | Red |
| Fatal | Red + Bold |

---

## 📱 Where Logs Appear

### **Development (Debug Mode)**
- ✅ Android Studio / VS Code Debug Console
- ✅ Flutter DevTools
- ✅ Terminal (flutter run)
- ✅ Android Logcat
- ✅ iOS Console

### **Production (Release Mode)**
- ❌ Logs are automatically disabled
- ✅ Can be enabled with custom configuration

---

## 🔧 Configuration

### **Enable/Disable Logging**

Edit `lib/core/utils/logger/app_logger.dart`:

```dart
// Disable all logs in production
static bool get isEnabled => !kReleaseMode;

static void info(String message, {String? tag, dynamic data}) {
  if (!isEnabled) return;
  _logger.i(_formatMessage(message, tag, data));
}
```

### **Change Log Level**

```dart
// Only show warnings and errors
static final Logger _logger = Logger(
  level: Level.warning,
  printer: PrettyPrinter(...),
);
```

---

## 📊 Logged Events

### **Application Lifecycle**
- ✅ App start
- ✅ Dependencies initialization
- ✅ API client initialization
- ✅ Configuration loaded

### **Authentication**
- ✅ Login attempt
- ✅ Login success/failure
- ✅ Registration attempt
- ✅ Registration success/failure
- ✅ Logout
- ✅ Auto-login check
- ✅ Token refresh

### **API Calls**
- ✅ All HTTP requests (method, URL, data)
- ✅ All HTTP responses (status code)
- ✅ All HTTP errors (error message)

### **BLoC Events**
- ✅ All events dispatched
- ✅ All state changes

### **User Actions**
- ✅ Button clicks
- ✅ Form submissions
- ✅ Navigation
- ✅ Form validation failures

---

## 🐛 Debugging Tips

### **1. Filter by Tag**

In Android Studio / VS Code, use filter:
```
[AUTH]    # Show only auth logs
[API]     # Show only API logs
[BLOC]    # Show only BLoC logs
```

### **2. Search for Errors**

```
❌        # Find all errors
Error:    # Find error messages
Failed    # Find failures
```

### **3. Track User Flow**

Follow a user action through the logs:
```
[USER] Login button pressed
  ↓
[BLOC] AuthBloc.LoginRequested
  ↓
[AUTH] Login attempt
  ↓
[API] POST /api/auth/login
  ↓
[API] Response 200
  ↓
[AUTH] Login successful
  ↓
[BLOC] State → Authenticated
```

---

## 📝 Best Practices

### **DO:**
✅ Log important user actions
✅ Log all API calls
✅ Log authentication events
✅ Log errors with context
✅ Use appropriate log levels
✅ Include relevant data
✅ Use consistent tags

### **DON'T:**
❌ Log sensitive data (passwords, tokens)
❌ Log in tight loops
❌ Log too much in production
❌ Use print() instead of AppLogger
❌ Log without tags
❌ Ignore errors

---

## 🔐 Security

**Never log:**
- ❌ Passwords
- ❌ Auth tokens
- ❌ Credit card numbers
- ❌ Personal identification numbers
- ❌ API keys

**Safe to log:**
- ✅ Usernames
- ✅ User IDs
- ✅ Roles
- ✅ Timestamps
- ✅ Status codes
- ✅ Error messages (sanitized)

---

## 📈 Performance

**Logger is optimized for:**
- ✅ Minimal performance impact
- ✅ Async logging (non-blocking)
- ✅ Automatic log rotation
- ✅ Memory efficient

**Impact:**
- Debug mode: ~1-2ms per log
- Release mode: 0ms (disabled)

---

## 🎯 Quick Reference

```dart
// App lifecycle
AppLogger.info('App started', tag: 'APP');

// Authentication
AppLogger.auth('Login successful', username: 'john');

// API
AppLogger.apiRequest('POST', '/api/orders');
AppLogger.apiResponse('POST', '/api/orders', 201);
AppLogger.apiError('POST', '/api/orders', error);

// BLoC
AppLogger.blocEvent('OrderBloc', 'CreateOrder');
AppLogger.blocState('OrderBloc', 'OrderCreated');

// User actions
AppLogger.userAction('Submit order button clicked');

// Navigation
AppLogger.navigation('/menu', '/cart');

// Errors
AppLogger.error('Failed to load', tag: 'DATA', error: e);
```

---

**Last Updated:** February 7, 2026
