# 📱 RestoApp - Flutter Mobile Application

## Complete Planning & Architecture Documentation

---

## 📋 Project Overview

| Property | Value |
|----------|-------|
| **Nama Aplikasi** | RestoApp |
| **Platform** | Mobile (Android & iOS) |
| **Framework** | Flutter 3.x |
| **Language** | Dart |
| **Database** | MySQL (sama dengan web app - `restaus_db`) |
| **Architecture** | Clean Architecture + BLoC Pattern |
| **Target** | Aplikasi mobile POS restoran yang identik dengan versi web RESTAUS |

---

## 🎯 Project Objectives

### Primary Goals
1. Membuat aplikasi mobile Flutter yang memiliki **fitur dan tampilan identik** dengan aplikasi web RESTAUS
2. Menggunakan **database MySQL yang sama** (`restaus_db`) untuk sinkronisasi data real-time
3. Mendukung **multi-user dengan role-based access** (Admin, Waiter, Kitchen, Cashier, Customer)
4. Memberikan pengalaman **native mobile** dengan performa optimal

### Key Features Parity
- ✅ Semua fitur dari web app akan di-port ke mobile
- ✅ UI/UX dioptimasi untuk layar sentuh mobile
- ✅ Offline-first capability dengan local caching
- ✅ Push notifications untuk real-time updates

---

## 🗄️ Database Schema (Shared with Web App)

### Database: `restaus_db`

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DATABASE SCHEMA                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────┐      ┌──────────────┐      ┌─────────────┐                   │
│  │  users   │      │  categories  │      │   tables    │                   │
│  ├──────────┤      ├──────────────┤      ├─────────────┤                   │
│  │ id       │      │ id           │      │ id          │                   │
│  │ username │      │ name         │      │ table_number│                   │
│  │ password │      │ icon         │      │ capacity    │                   │
│  │ role     │      │ sort_order   │      │ status      │                   │
│  │ full_name│      └──────┬───────┘      └──────┬──────┘                   │
│  └────┬─────┘             │                     │                          │
│       │                   │                     │                          │
│       │              ┌────▼─────┐               │                          │
│       │              │  menus   │               │                          │
│       │              ├──────────┤               │                          │
│       │              │ id       │               │                          │
│       │              │category_id               │                          │
│       │              │ name     │               │                          │
│       │              │ price    │               │                          │
│       │              │ is_active│               │                          │
│       │              └────┬─────┘               │                          │
│       │                   │                     │                          │
│       │              ┌────▼───────┐             │                          │
│       │              │inventories │             │                          │
│       │              ├────────────┤             │                          │
│       │              │ menu_id    │             │                          │
│       │              │daily_stock │             │                          │
│       │              │remaining   │             │                          │
│       │              └────────────┘             │                          │
│       │                                         │                          │
│       │         ┌───────────────────────────────┤                          │
│       │         │                               │                          │
│       │    ┌────▼─────┐                   ┌─────▼─────┐                    │
│       │    │  orders  │◄──────────────────│order_items│                    │
│       │    ├──────────┤                   ├───────────┤                    │
│       │    │ id       │                   │ id        │                    │
│       └───►│ user_id  │                   │ order_id  │                    │
│            │ table_id │                   │ menu_id   │                    │
│            │ status   │                   │ quantity  │                    │
│            │ total    │                   │ status    │                    │
│            └────┬─────┘                   │ notes     │                    │
│                 │                         └───────────┘                    │
│            ┌────▼─────┐                                                    │
│            │ payments │                                                    │
│            ├──────────┤                                                    │
│            │ order_id │                                                    │
│            │cashier_id│                                                    │
│            │ method   │                                                    │
│            │ amount   │                                                    │
│            └──────────┘                                                    │
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘
```

### Tables Detail

| Table | Primary Key | Description |
|-------|-------------|-------------|
| `users` | id (INT) | Data karyawan dengan role (admin/waiter/cashier/kitchen) |
| `categories` | id (INT) | Kategori menu (Makanan Berat, Minuman, Dessert) |
| `menus` | id (INT) | Daftar menu dengan harga, gambar, status aktif |
| `tables` | id (INT) | Data meja fisik dengan status |
| `inventories` | id (INT) | Stok harian per menu |
| `orders` | id (INT) | Header transaksi pesanan |
| `order_items` | id (INT) | Detail item dalam pesanan |
| `payments` | id (INT) | Record pembayaran |

### Enum Definitions

```dart
// User Roles
enum UserRole { admin, waiter, cashier, kitchen }

// Table Status
enum TableStatus { available, reserved, occupied }

// Order Types
enum OrderType { dineIn, takeAway }

// Order Status Flow
enum OrderStatus { pending, processing, delivered, completed, cancelled }

// Order Item Status
enum OrderItemStatus { pending, cooking, served }

// Payment Methods
enum PaymentMethod { cash, qris, debit }
```

---

## 🏗️ Technology Stack

### Core Technologies

| Component | Technology | Version |
|-----------|------------|---------|
| **Framework** | Flutter | 3.19+ |
| **Language** | Dart | 3.3+ |
| **State Management** | flutter_bloc | 8.x |
| **DI** | get_it + injectable | Latest |
| **Routing** | go_router | 13.x |
| **API Client** | dio | 5.x |
| **Local Storage** | hive / shared_preferences | Latest |

### UI & Design

| Component | Technology |
|-----------|------------|
| **Design System** | Material Design 3 |
| **Icons** | Material Icons + Lucide |
| **Fonts** | Google Fonts (Inter/Poppins) |
| **Animations** | flutter_animate |
| **Charts** | fl_chart |

### Backend Integration

| Component | Technology |
|-----------|------------|
| **REST API** | dio + retrofit |
| **Real-time** | web_socket_channel / SSE |
| **Image Loading** | cached_network_image |
| **PDF Generation** | pdf / printing |

### Development Tools

| Tool | Purpose |
|------|---------|
| **Code Generation** | build_runner, freezed, json_serializable |
| **Linting** | flutter_lints, very_good_analysis |
| **Testing** | flutter_test, mockito, bloc_test |
| **CI/CD** | GitHub Actions / Codemagic |

---

## 📁 Project Structure

```
restoapp/
├── android/                          # Android native code
├── ios/                              # iOS native code
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # MaterialApp configuration
│   │
│   ├── core/                         # Core utilities & shared code
│   │   ├── config/
│   │   │   ├── app_config.dart       # Environment config
│   │   │   ├── api_config.dart       # API endpoints
│   │   │   └── theme_config.dart     # App theming
│   │   │
│   │   ├── constants/
│   │   │   ├── app_constants.dart    # App-wide constants
│   │   │   ├── api_endpoints.dart    # API route constants
│   │   │   └── asset_paths.dart      # Asset path constants
│   │   │
│   │   ├── di/
│   │   │   ├── injection.dart        # Dependency injection setup
│   │   │   └── injection.config.dart # Generated DI config
│   │   │
│   │   ├── error/
│   │   │   ├── exceptions.dart       # Custom exceptions
│   │   │   └── failures.dart         # Failure classes
│   │   │
│   │   ├── network/
│   │   │   ├── api_client.dart       # Dio setup & interceptors
│   │   │   ├── network_info.dart     # Connectivity checker
│   │   │   └── api_response.dart     # Generic API response wrapper
│   │   │
│   │   ├── router/
│   │   │   ├── app_router.dart       # GoRouter configuration
│   │   │   └── route_names.dart      # Route name constants
│   │   │
│   │   ├── theme/
│   │   │   ├── app_theme.dart        # Theme definitions
│   │   │   ├── app_colors.dart       # Color palette
│   │   │   ├── app_typography.dart   # Text styles
│   │   │   └── app_decorations.dart  # Common decorations
│   │   │
│   │   └── utils/
│   │       ├── extensions/           # Dart extensions
│   │       ├── formatters/           # Currency, date formatters
│   │       ├── validators/           # Input validators
│   │       └── helpers/              # Utility functions
│   │
│   ├── data/                         # Data layer
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   ├── menu_local_datasource.dart
│   │   │   │   └── cart_local_datasource.dart
│   │   │   │
│   │   │   └── remote/
│   │   │       ├── auth_remote_datasource.dart
│   │   │       ├── menu_remote_datasource.dart
│   │   │       ├── table_remote_datasource.dart
│   │   │       ├── order_remote_datasource.dart
│   │   │       └── payment_remote_datasource.dart
│   │   │
│   │   ├── models/                   # Data transfer objects
│   │   │   ├── user_model.dart
│   │   │   ├── category_model.dart
│   │   │   ├── menu_model.dart
│   │   │   ├── table_model.dart
│   │   │   ├── inventory_model.dart
│   │   │   ├── order_model.dart
│   │   │   ├── order_item_model.dart
│   │   │   └── payment_model.dart
│   │   │
│   │   └── repositories/             # Repository implementations
│   │       ├── auth_repository_impl.dart
│   │       ├── menu_repository_impl.dart
│   │       ├── table_repository_impl.dart
│   │       ├── order_repository_impl.dart
│   │       └── payment_repository_impl.dart
│   │
│   ├── domain/                       # Domain/Business layer
│   │   ├── entities/                 # Business entities
│   │   │   ├── user.dart
│   │   │   ├── category.dart
│   │   │   ├── menu.dart
│   │   │   ├── restaurant_table.dart
│   │   │   ├── inventory.dart
│   │   │   ├── order.dart
│   │   │   ├── order_item.dart
│   │   │   ├── payment.dart
│   │   │   └── cart.dart
│   │   │
│   │   ├── repositories/             # Repository interfaces
│   │   │   ├── auth_repository.dart
│   │   │   ├── menu_repository.dart
│   │   │   ├── table_repository.dart
│   │   │   ├── order_repository.dart
│   │   │   └── payment_repository.dart
│   │   │
│   │   └── usecases/                 # Business use cases
│   │       ├── auth/
│   │       │   ├── login_usecase.dart
│   │       │   ├── logout_usecase.dart
│   │       │   └── get_current_user_usecase.dart
│   │       ├── menu/
│   │       │   ├── get_menus_usecase.dart
│   │       │   ├── get_categories_usecase.dart
│   │       │   └── update_menu_usecase.dart
│   │       ├── table/
│   │       │   ├── get_tables_usecase.dart
│   │       │   └── update_table_status_usecase.dart
│   │       ├── order/
│   │       │   ├── create_order_usecase.dart
│   │       │   ├── get_orders_usecase.dart
│   │       │   ├── update_order_status_usecase.dart
│   │       │   └── update_order_item_status_usecase.dart
│   │       └── payment/
│   │           ├── process_payment_usecase.dart
│   │           └── get_payment_usecase.dart
│   │
│   └── presentation/                 # UI layer
│       ├── blocs/                    # BLoC state management
│       │   ├── auth/
│       │   │   ├── auth_bloc.dart
│       │   │   ├── auth_event.dart
│       │   │   └── auth_state.dart
│       │   ├── menu/
│       │   │   ├── menu_bloc.dart
│       │   │   ├── menu_event.dart
│       │   │   └── menu_state.dart
│       │   ├── table/
│       │   │   ├── table_bloc.dart
│       │   │   ├── table_event.dart
│       │   │   └── table_state.dart
│       │   ├── order/
│       │   │   ├── order_bloc.dart
│       │   │   ├── order_event.dart
│       │   │   └── order_state.dart
│       │   ├── cart/
│       │   │   ├── cart_bloc.dart
│       │   │   ├── cart_event.dart
│       │   │   └── cart_state.dart
│       │   ├── kitchen/
│       │   │   ├── kitchen_bloc.dart
│       │   │   ├── kitchen_event.dart
│       │   │   └── kitchen_state.dart
│       │   └── payment/
│       │       ├── payment_bloc.dart
│       │       ├── payment_event.dart
│       │       └── payment_state.dart
│       │
│       ├── pages/                    # Screen pages
│       │   ├── splash/
│       │   │   └── splash_page.dart
│       │   │
│       │   ├── auth/
│       │   │   ├── login_page.dart
│       │   │   └── widgets/
│       │   │       ├── login_form.dart
│       │   │       └── role_selector.dart
│       │   │
│       │   ├── admin/
│       │   │   ├── admin_dashboard_page.dart
│       │   │   ├── menu_management_page.dart
│       │   │   ├── table_management_page.dart
│       │   │   ├── user_management_page.dart
│       │   │   ├── settings_page.dart
│       │   │   └── widgets/
│       │   │       ├── stats_card.dart
│       │   │       ├── menu_form_dialog.dart
│       │   │       ├── table_form_dialog.dart
│       │   │       ├── user_form_dialog.dart
│       │   │       └── sales_chart.dart
│       │   │
│       │   ├── waiter/
│       │   │   ├── waiter_dashboard_page.dart
│       │   │   ├── new_order_page.dart
│       │   │   └── widgets/
│       │   │       ├── table_grid.dart
│       │   │       ├── menu_catalog.dart
│       │   │       └── cart_summary.dart
│       │   │
│       │   ├── kitchen/
│       │   │   ├── kitchen_dashboard_page.dart
│       │   │   └── widgets/
│       │   │       ├── order_queue.dart
│       │   │       └── kitchen_order_card.dart
│       │   │
│       │   ├── cashier/
│       │   │   ├── cashier_dashboard_page.dart
│       │   │   └── widgets/
│       │   │       ├── pending_orders_list.dart
│       │   │       ├── payment_form.dart
│       │   │       └── order_summary_card.dart
│       │   │
│       │   ├── customer/
│       │   │   ├── table_selection_page.dart
│       │   │   ├── customer_menu_page.dart
│       │   │   ├── customer_cart_page.dart
│       │   │   ├── order_status_page.dart
│       │   │   └── widgets/
│       │   │       ├── menu_item_card.dart
│       │   │       └── order_tracker.dart
│       │   │
│       │   └── receipt/
│       │       └── receipt_page.dart
│       │
│       └── widgets/                  # Shared/reusable widgets
│           ├── common/
│           │   ├── app_bar_widget.dart
│           │   ├── loading_widget.dart
│           │   ├── error_widget.dart
│           │   ├── empty_state_widget.dart
│           │   └── refresh_indicator_widget.dart
│           │
│           ├── atoms/
│           │   ├── status_badge.dart
│           │   ├── price_tag.dart
│           │   ├── quantity_selector.dart
│           │   └── category_chip.dart
│           │
│           ├── molecules/
│           │   ├── table_card.dart
│           │   ├── menu_item_card.dart
│           │   ├── order_item_tile.dart
│           │   └── cart_item_tile.dart
│           │
│           └── organisms/
│               ├── table_grid_view.dart
│               ├── menu_grid_view.dart
│               ├── category_tabs.dart
│               ├── cart_bottom_sheet.dart
│               └── payment_modal.dart
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   ├── placeholder_food.png
│   │   └── empty_state.png
│   │
│   ├── icons/
│   │   └── custom_icons/
│   │
│   └── fonts/
│       └── (Google Fonts loaded dynamically)
│
├── test/                             # Test files
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── pubspec.yaml                      # Dependencies
├── analysis_options.yaml             # Linting rules
└── README.md
```

---

## 🖥️ Module & Feature Breakdown

### Module 1: Authentication

#### 1.1 Login Page
| Feature | Description | Priority |
|---------|-------------|----------|
| Login Form | Username & password input dengan validasi | High |
| Remember Me | Simpan credentials secara aman | Medium |
| Role Detection | Auto-redirect berdasarkan user role | High |
| Biometric Auth | Fingerprint/Face ID login (optional) | Low |

#### 1.2 Session Management
| Feature | Description | Priority |
|---------|-------------|----------|
| Token Storage | Secure storage untuk auth token | High |
| Auto Refresh | Token refresh mechanism | High |
| Session Timeout | Auto logout setelah inactive | Medium |
| Logout | Clear session & redirect ke login | High |

**UI Mockup - Login:**
```
┌────────────────────────────────────┐
│                                    │
│         🍽️ RestoApp               │
│      Restaurant Management         │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  👤  Username                │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  🔒  Password                │  │
│  └──────────────────────────────┘  │
│                                    │
│         [ ☐ Remember Me ]          │
│                                    │
│  ┌──────────────────────────────┐  │
│  │         LOGIN                │  │
│  └──────────────────────────────┘  │
│                                    │
└────────────────────────────────────┘
```

---

### Module 2: Admin Dashboard

#### 2.1 Dashboard Overview
| Feature | Description |
|---------|-------------|
| Stats Cards | Total revenue, orders, occupied tables, warnings |
| Sales Chart | Weekly/monthly sales visualization |
| Recent Orders | Latest 5 orders with quick actions |
| Quick Navigation | Cards to sub-modules |

#### 2.2 Menu Management
| Feature | Description |
|---------|-------------|
| Menu List | Searchable & filterable data table |
| Add Menu | Form: name, price, category, image, description |
| Edit Menu | Edit existing menu items |
| Toggle Status | Activate/deactivate menu |
| Stock Management | Update daily stock levels |
| Delete Menu | Soft delete with confirmation |

#### 2.3 Table Management
| Feature | Description |
|---------|-------------|
| Table List | Grid view all tables |
| Add Table | Form: number, capacity |
| Edit Table | Modify table details |
| Status Override | Manual status change |
| Delete Table | Remove table |

#### 2.4 User Management
| Feature | Description |
|---------|-------------|
| User List | All staff members |
| Add User | Create new staff account |
| Edit User | Modify user details & role |
| Reset Password | Admin password reset |
| Deactivate User | Disable user account |

**UI Mockup - Admin Dashboard:**
```
┌────────────────────────────────────────────────────┐
│  ☰  Admin Dashboard                    👤 Admin ▼  │
├────────────────────────────────────────────────────┤
│                                                    │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌───────┐ │
│  │ Revenue  │ │ Orders   │ │ Tables   │ │ Warn  │ │
│  │ Rp 2.5M  │ │ 45       │ │ 7/10     │ │ 2 ⚠️  │ │
│  └──────────┘ └──────────┘ └──────────┘ └───────┘ │
│                                                    │
│  ┌──────────────────────────────────────────────┐ │
│  │                                              │ │
│  │           Weekly Sales Chart                 │ │
│  │     📊 ████  ████  ████  ████  ████         │ │
│  │        Mon   Tue   Wed   Thu   Fri          │ │
│  │                                              │ │
│  └──────────────────────────────────────────────┘ │
│                                                    │
│  Recent Orders                          [View All] │
│  ┌──────────────────────────────────────────────┐ │
│  │ #1234 | Table 5 | Rp 125K | Completed ✅     │ │
│  │ #1233 | Table 3 | Rp 89K  | Processing 🔄    │ │
│  │ #1232 | Table 8 | Rp 156K | Delivered 📦     │ │
│  └──────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────┘
```

---

### Module 3: Waiter Module

#### 3.1 Table Grid Dashboard
| Feature | Description |
|---------|-------------|
| Table Grid | Visual grid semua meja dengan warna status |
| Status Legend | Available (green), Occupied (blue), Reserved (yellow), Warning (red) |
| Stats Bar | Total, Available, Occupied, Warnings count |
| Auto-Refresh | Polling setiap 5-10 detik |
| Pull to Refresh | Manual refresh gesture |

#### 3.2 New Order Page
| Feature | Description |
|---------|-------------|
| Table Info | Display selected table info |
| Category Tabs | Horizontal scrollable category filter |
| Menu Grid | 2-column grid menu items |
| Search | Search menu by name |
| Add to Cart | Tap menu to add, long press for notes |
| Cart Summary | Bottom sheet with cart items |
| Quantity Control | +/- buttons untuk adjust quantity |
| Special Notes | Input catatan per item |
| Submit Order | Send order to kitchen |

**UI Mockup - Waiter Dashboard:**
```
┌────────────────────────────────────┐
│  🍽️ RESTAUS          🔄 [Refresh]  │
│  Waiter Dashboard      👤 John     │
├────────────────────────────────────┤
│                                    │
│  📊 Tables: 10 | ✅ 5 | 🔵 4 | ⚠️ 1  │
│                                    │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐      │
│  │ T1 │ │ T2 │ │ T3 │ │ T4 │      │
│  │ 🟢 │ │ 🔵 │ │ 🔵 │ │ 🟢 │      │
│  │ 4👤 │ │ 2👤 │ │ 4👤 │ │ 6👤 │      │
│  └────┘ └────┘ └────┘ └────┘      │
│                                    │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐      │
│  │ T5 │ │ T6 │ │ T7 │ │ T8 │      │
│  │ 🟡 │ │ 🔴 │ │ 🟢 │ │ 🔵 │      │
│  │ 2👤 │ │ 8👤 │ │ 4👤 │ │ 2👤 │      │
│  └────┘ └────┘ └────┘ └────┘      │
│                                    │
│  ┌────┐ ┌────┐                     │
│  │ T9 │ │T10 │                     │
│  │ 🟢 │ │ 🔵 │                     │
│  │ 6👤 │ │ 4👤 │                     │
│  └────┘ └────┘                     │
│                                    │
│        Legend:                     │
│  🟢 Available  🔵 Occupied         │
│  🟡 Reserved   🔴 Warning          │
│                                    │
└────────────────────────────────────┘
```

**UI Mockup - New Order:**
```
┌────────────────────────────────────┐
│  ← New Order           Table T5    │
├────────────────────────────────────┤
│  🔍 Search menu...                 │
├────────────────────────────────────┤
│  [All] [Food] [Drinks] [Dessert]   │
├────────────────────────────────────┤
│                                    │
│  ┌───────────┐ ┌───────────┐      │
│  │   🍛      │ │   🍜      │      │
│  │ Nasi      │ │ Mie       │      │
│  │ Goreng    │ │ Goreng    │      │
│  │ Rp 25.000 │ │ Rp 20.000 │      │
│  │  [+Add]   │ │  [+Add]   │      │
│  └───────────┘ └───────────┘      │
│                                    │
│  ┌───────────┐ ┌───────────┐      │
│  │   🍗      │ │   🥘      │      │
│  │ Ayam      │ │ Soto      │      │
│  │ Bakar     │ │ Ayam      │      │
│  │ Rp 35.000 │ │ Rp 22.000 │      │
│  │  [+Add]   │ │  [+Add]   │      │
│  └───────────┘ └───────────┘      │
│                                    │
├────────────────────────────────────┤
│  🛒 Cart (3 items)     Rp 82.000  │
│  [           View Cart           ] │
└────────────────────────────────────┘
```

---

### Module 4: Kitchen Display System (KDS)

#### 4.1 Order Queue
| Feature | Description |
|---------|-------------|
| Order Cards | Cards per order dengan info meja & items |
| Time Elapsed | "Ordered X mins ago" indicator |
| Item Status | Per-item status badges |
| Status Update | Tap item to change status (Pending → Cooking → Served) |
| Complete Order | Auto-complete when all items served |
| Late Warning | Visual indicator for orders > 20 mins |
| Sound Alert | Audio notification untuk order baru |

**UI Mockup - Kitchen:**
```
┌────────────────────────────────────┐
│  🍳 KDS - Kitchen Display   🔴 LIVE │
├────────────────────────────────────┤
│  Pending Orders: 5                 │
├────────────────────────────────────┤
│                                    │
│  ┌──────────────────────────────┐  │
│  │ 📍 Table 5        ⏱️ 3 mins  │  │
│  │ Order #1234                  │  │
│  ├──────────────────────────────┤  │
│  │ ○ Nasi Goreng x2    [Start]  │  │
│  │   "Pedas sedang"             │  │
│  │ ● Ayam Bakar x1   [Cooking]  │  │
│  │ ✓ Es Teh x2       [Served]   │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │ 📍 Table 3       ⏱️ 12 mins  │  │
│  │ Order #1235          ⚠️      │  │
│  ├──────────────────────────────┤  │
│  │ ● Mie Goreng x1   [Cooking]  │  │
│  │ ● Soto Ayam x2    [Cooking]  │  │
│  │ ○ Jus Alpukat x3   [Start]   │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │ 📍 Table 8       ⏱️ 25 mins  │  │
│  │ Order #1236          🔴      │  │
│  ├──────────────────────────────┤  │
│  │ ○ Gado-Gado x1     [Start]   │  │
│  └──────────────────────────────┘  │
│                                    │
└────────────────────────────────────┘
```

---

### Module 5: Cashier/POS Module

#### 5.1 Pending Payments
| Feature | Description |
|---------|-------------|
| Order List | Orders dengan status "delivered" |
| Search | Search by table/name/order ID |
| Order Detail | Tap to view full order details |
| Quick Info | Table, items count, total amount |

#### 5.2 Payment Processing
| Feature | Description |
|---------|-------------|
| Order Summary | Full breakdown of items & prices |
| Payment Method | Select: Cash, QRIS, Debit |
| Amount Input | Numpad input untuk cash |
| Change Calculator | Auto-calculate kembalian |
| Process Payment | Complete transaction |
| Print Receipt | Generate & print struk |

**UI Mockup - Cashier:**
```
┌────────────────────────────────────┐
│  💰 Cashier POS          👤 Sarah  │
├────────────────────────────────────┤
│  🔍 Search table, name, order...   │
├────────────┬───────────────────────┤
│ Pending    │                       │
│ Payments   │    Order Details      │
│            │                       │
│ ┌────────┐ │  Order #1234          │
│ │ T5     │ │  Table 5              │
│ │ #1234  │ │  Waiter: John         │
│ │ Rp 82K │ │                       │
│ │ ●      │ │  ─────────────────    │
│ └────────┘ │  Nasi Goreng x2       │
│            │           Rp 50.000   │
│ ┌────────┐ │  Ayam Bakar x1        │
│ │ T3     │ │           Rp 35.000   │
│ │ #1235  │ │  Es Teh x2            │
│ │ Rp115K │ │           Rp 10.000   │
│ └────────┘ │  ─────────────────    │
│            │  Subtotal   Rp 95.000 │
│ ┌────────┐ │  Tax (0%)   Rp 0      │
│ │ T8     │ │  ═════════════════    │
│ │ #1236  │ │  TOTAL     Rp 95.000  │
│ │ Rp 18K │ │                       │
│ └────────┘ │  Payment Method:      │
│            │  [Cash] [QRIS] [Debit]│
│            │                       │
│            │  Amount: Rp [100.000] │
│            │  Change: Rp 5.000     │
│            │                       │
│            │  [    PAY NOW    ]    │
└────────────┴───────────────────────┘
```

---

### Module 6: Customer Self-Order (Optional Feature)

#### 6.1 Table Selection
| Feature | Description |
|---------|-------------|
| QR Code Scan | Scan QR di meja untuk auto-select |
| Table Grid | Manual table selection |
| Table Status | Show availability |

#### 6.2 Menu Browsing
| Feature | Description |
|---------|-------------|
| Menu Display | Attractive food images & descriptions |
| Category Filter | Browse by category |
| Search | Find specific items |
| Add to Cart | Quick add with quantity |

#### 6.3 Cart & Checkout
| Feature | Description |
|---------|-------------|
| Cart View | Review items sebelum order |
| Edit Items | Modify quantity, add notes |
| Place Order | Submit to kitchen |
| Order Tracking | Real-time status tracking |

**UI Mockup - Customer:**
```
┌────────────────────────────────────┐
│  🍽️ RestoApp                       │
│  Welcome! Select your table        │
├────────────────────────────────────┤
│                                    │
│       [📷 Scan Table QR]           │
│                                    │
│         ── or select ──            │
│                                    │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐      │
│  │ T1 │ │ T2 │ │ T3 │ │ T4 │      │
│  │ ✓  │ │ ✗  │ │ ✗  │ │ ✓  │      │
│  └────┘ └────┘ └────┘ └────┘      │
│                                    │
│  ✓ = Available   ✗ = Occupied      │
│                                    │
└────────────────────────────────────┘
```

---

### Module 7: Receipt

#### 7.1 Receipt Preview
| Feature | Description |
|---------|-------------|
| Restaurant Info | Logo, name, address |
| Order Info | ID, table, date, waiter |
| Item List | Name, qty, price, subtotal |
| Payment Info | Method, amount, change |
| Footer | Thank you message |

#### 7.2 Actions
| Feature | Description |
|---------|-------------|
| Print | Send to thermal printer |
| Share | Share as image/PDF |
| Download | Save as PDF |

**UI Mockup - Receipt:**
```
┌────────────────────────────────────┐
│  Receipt Preview          [Share]  │
├────────────────────────────────────┤
│                                    │
│  ┌──────────────────────────────┐  │
│  │       🍽️ RESTAUS             │  │
│  │    Restaurant & Cafe         │  │
│  │   Jl. Contoh No. 123         │  │
│  │                              │  │
│  │  ════════════════════════    │  │
│  │  Order: #1234                │  │
│  │  Table: T5                   │  │
│  │  Date: 07 Feb 2026 14:30     │  │
│  │  Waiter: John                │  │
│  │  ════════════════════════    │  │
│  │                              │  │
│  │  Nasi Goreng    2   50,000   │  │
│  │  Ayam Bakar     1   35,000   │  │
│  │  Es Teh         2   10,000   │  │
│  │  ────────────────────────    │  │
│  │  Subtotal          95,000    │  │
│  │  Tax                    0    │  │
│  │  ════════════════════════    │  │
│  │  TOTAL            95,000     │  │
│  │  ════════════════════════    │  │
│  │  Payment: Cash              │  │
│  │  Paid:       100,000        │  │
│  │  Change:       5,000        │  │
│  │                              │  │
│  │  ════════════════════════    │  │
│  │     Thank you for dining!    │  │
│  │       Please come again      │  │
│  └──────────────────────────────┘  │
│                                    │
│  [  Print  ]     [  Download  ]    │
│                                    │
└────────────────────────────────────┘
```

---

## 🎨 UI/UX Design Specifications

### Color Palette

```dart
class AppColors {
  // Primary Colors (Orange theme - sama dengan web)
  static const primary = Color(0xFFF97316);      // Orange 500
  static const primaryDark = Color(0xFFEA580C);  // Orange 600
  static const primaryLight = Color(0xFFFB923C); // Orange 400
  
  // Accent Colors
  static const accent = Color(0xFFD97706);       // Amber 600
  
  // Status Colors
  static const success = Color(0xFF22C55E);      // Green 500
  static const warning = Color(0xFFEAB308);      // Yellow 500
  static const error = Color(0xFFEF4444);        // Red 500
  static const info = Color(0xFF3B82F6);         // Blue 500
  
  // Table Status Colors
  static const tableAvailable = Color(0xFF22C55E);  // Green
  static const tableOccupied = Color(0xFF3B82F6);   // Blue
  static const tableReserved = Color(0xFFEAB308);   // Yellow
  static const tableWarning = Color(0xFFEF4444);    // Red
  
  // Neutral Colors
  static const background = Color(0xFFFFF7ED);   // Orange 50
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111827);  // Gray 900
  static const textSecondary = Color(0xFF6B7280);// Gray 500
  static const border = Color(0xFFE5E7EB);       // Gray 200
  
  // Dark Mode
  static const darkBackground = Color(0xFF111827);
  static const darkSurface = Color(0xFF1F2937);
}
```

### Typography

```dart
class AppTypography {
  // Headings
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  static const h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Body
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  // Labels
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  
  static const labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
```

### Component Styles

| Component | Style |
|-----------|-------|
| Cards | Border radius: 12px, Elevation: 2, White background |
| Buttons | Border radius: 8px, Height: 48px, Gradient primary |
| Input Fields | Border radius: 8px, Height: 48px, Gray border |
| Badges | Border radius: 9999px (pill), Small padding |
| Dialogs | Border radius: 16px, Max width: 400px |

### Spacing System

```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}
```

---

## 📡 API Integration

### Base Configuration

```dart
// API Base URL (sama dengan web app)
const String baseUrl = 'http://your-server.com/api';

// Endpoints
class ApiEndpoints {
  // Auth
  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const register = '/auth/register';
  
  // Categories
  static const categories = '/categories';
  
  // Menus
  static const menus = '/menus';
  static String menuById(int id) => '/menus/$id';
  static String menuStatus(int id) => '/menus/$id/status';
  
  // Tables
  static const tables = '/tables';
  static String tableById(int id) => '/tables/$id';
  static String tableStatus(int id) => '/tables/$id/status';
  
  // Orders
  static const orders = '/orders';
  static String orderById(int id) => '/orders/$id';
  static String orderStatus(int id) => '/orders/$id/status';
  
  // Order Items
  static String orderItemStatus(int id) => '/order-items/$id/status';
  
  // Payments
  static const payments = '/payments';
  
  // Users
  static const users = '/users';
  static String userById(int id) => '/users/$id';
}
```

### API Response Format

```dart
// Standard API Response
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;
  
  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });
}

// Paginated Response
class PaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
}
```

---

## 🔄 State Management (BLoC)

### Auth BLoC Example

```dart
// Events
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String username;
  final String password;
}
class LogoutRequested extends AuthEvent {}
class CheckAuthStatus extends AuthEvent {}

// States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  
  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }
  
  // ... implementation
}
```

---

## 📊 Implementation Phases

### Phase 1: Foundation (Week 1-2)
| Task | Description | Status |
|------|-------------|--------|
| Project Setup | Create Flutter project, configure pubspec.yaml | ⬜ |
| Folder Structure | Implement clean architecture folders | ⬜ |
| Theme Setup | Define colors, typography, themes | ⬜ |
| DI Setup | Configure get_it & injectable | ⬜ |
| Router Setup | Configure go_router with guards | ⬜ |
| API Client | Setup Dio with interceptors | ⬜ |
| Models | Create all data models with freezed | ⬜ |

### Phase 2: Authentication (Week 2-3)
| Task | Description | Status |
|------|-------------|--------|
| Login UI | Build login page with form | ⬜ |
| Auth BLoC | Implement authentication state management | ⬜ |
| Auth Repository | Connect to API | ⬜ |
| Session Storage | Secure token storage | ⬜ |
| Route Guards | Protect routes by role | ⬜ |

### Phase 3: Admin Module (Week 3-4)
| Task | Description | Status |
|------|-------------|--------|
| Dashboard UI | Stats cards, charts | ⬜ |
| Menu Management | CRUD operations | ⬜ |
| Table Management | CRUD operations | ⬜ |
| User Management | CRUD operations | ⬜ |
| Settings Page | App configuration | ⬜ |

### Phase 4: Waiter Module (Week 4-5)
| Task | Description | Status |
|------|-------------|--------|
| Table Grid | Visual table status display | ⬜ |
| Table BLoC | Real-time updates with polling | ⬜ |
| Menu Catalog | Category tabs, search, grid | ⬜ |
| Cart System | Local cart state management | ⬜ |
| New Order UI | Complete order flow | ⬜ |
| Order Submission | API integration | ⬜ |

### Phase 5: Kitchen Module (Week 5-6)
| Task | Description | Status |
|------|-------------|--------|
| KDS UI | Order queue display | ⬜ |
| Order Cards | With item status buttons | ⬜ |
| Status Updates | Item & order status changes | ⬜ |
| Auto-refresh | Polling mechanism | ⬜ |
| Notifications | Sound alerts for new orders | ⬜ |

### Phase 6: Cashier Module (Week 6-7)
| Task | Description | Status |
|------|-------------|--------|
| POS Dashboard | Split view layout | ⬜ |
| Pending List | Filterable order list | ⬜ |
| Payment Form | Amount input, method selection | ⬜ |
| Change Calculator | Auto calculation | ⬜ |
| Process Payment | API integration | ⬜ |

### Phase 7: Receipt & Extras (Week 7-8)
| Task | Description | Status |
|------|-------------|--------|
| Receipt UI | Thermal-style preview | ⬜ |
| PDF Generation | Create downloadable receipt | ⬜ |
| Print Integration | Connect to printer | ⬜ |
| Customer Module | Self-ordering (optional) | ⬜ |

### Phase 8: Polish & Testing (Week 8-9)
| Task | Description | Status |
|------|-------------|--------|
| UI Polish | Animations, transitions | ⬜ |
| Error Handling | Comprehensive error UX | ⬜ |
| Offline Mode | Local caching strategy | ⬜ |
| Unit Tests | Test business logic | ⬜ |
| Widget Tests | Test UI components | ⬜ |
| Integration Tests | End-to-end flows | ⬜ |

---

## 📦 Dependencies (pubspec.yaml)

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
  retrofit: ^4.1.0
  connectivity_plus: ^5.0.2
  
  # Local Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # UI Components
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.9
  shimmer: ^3.0.0
  flutter_animate: ^4.5.0
  
  # Charts
  fl_chart: ^0.66.2
  
  # PDF & Printing
  pdf: ^3.10.7
  printing: ^5.12.0
  
  # Utilities
  intl: ^0.18.1
  logger: ^2.0.2
  
  # Icons
  lucide_icons: ^0.257.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  
  # Code Generation
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  injectable_generator: ^2.4.1
  retrofit_generator: ^8.1.0
  
  # Testing
  bloc_test: ^9.1.6
  mockito: ^5.4.4
  mocktail: ^1.0.3

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.19+
- Dart SDK 3.3+
- Android Studio / VS Code
- MySQL Server (running)

### Setup Steps

```bash
# 1. Clone/Create project
flutter create restoapp
cd restoapp

# 2. Install dependencies
flutter pub get

# 3. Generate code (models, DI)
dart run build_runner build --delete-conflicting-outputs

# 4. Configure API endpoint
# Edit lib/core/config/api_config.dart

# 5. Run app
flutter run
```

### Environment Configuration

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static const String appName = 'RestoApp';
  static const String apiBaseUrl = 'http://localhost:3000/api';
  
  // Feature flags
  static const bool enableCustomerMode = true;
  static const bool enableOfflineMode = false;
  static const bool enablePushNotifications = false;
  
  // Polling intervals
  static const Duration tableRefreshInterval = Duration(seconds: 10);
  static const Duration kitchenRefreshInterval = Duration(seconds: 5);
}
```

---

## 📝 Coding Standards

### Naming Conventions

```dart
// Files: snake_case
// login_page.dart, auth_bloc.dart, user_model.dart

// Classes: PascalCase
class UserRepository {}
class LoginUseCase {}

// Variables & Functions: camelCase
final userName = 'John';
void submitOrder() {}

// Constants: camelCase or SCREAMING_SNAKE_CASE
const defaultTimeout = Duration(seconds: 30);
const MAX_RETRY_COUNT = 3;

// Private: prefix with underscore
String _privateVariable;
void _privateMethod() {}
```

### File Organization

```dart
// Standard file structure
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Authentication BLoC
/// 
/// Handles user authentication state throughout the app.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ... implementation
}
```

---

## 🔐 Security Considerations

1. **Secure Storage**: Use `flutter_secure_storage` untuk tokens
2. **HTTPS**: Enforce HTTPS untuk semua API calls
3. **Input Validation**: Validate semua user input
4. **Session Timeout**: Implement auto-logout
5. **Obfuscation**: Enable code obfuscation untuk release

---

## 📱 Platform Specific

### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Permissions: Internet, Camera (QR scan)

### iOS
- Minimum iOS: 12.0
- Permissions: Camera (QR scan)

---

## 📋 Checklist Summary

### Core Files Count
| Layer | Files |
|-------|-------|
| Models | 8 |
| Repositories (Interface) | 5 |
| Repositories (Impl) | 5 |
| Use Cases | 15+ |
| BLoCs | 7 |
| Pages | 15+ |
| Widgets | 25+ |
| **Total** | **80+** |

### Feature Completion Target
| Module | Pages | Priority |
|--------|-------|----------|
| Auth | 1 | 🔴 High |
| Admin | 5 | 🟡 Medium |
| Waiter | 2 | 🔴 High |
| Kitchen | 1 | 🔴 High |
| Cashier | 1 | 🔴 High |
| Customer | 4 | 🟢 Low |
| Receipt | 1 | 🟡 Medium |

---

## 📌 Notes & Considerations

### Sinkronisasi dengan Web App
- Database yang sama memungkinkan real-time sync
- Perubahan di mobile langsung terlihat di web dan sebaliknya
- Perlu handle concurrent modifications

### Offline Capability (Future)
- Cache menu data untuk browsing offline
- Queue orders saat offline, sync saat online
- Local database dengan Hive/SQLite

### Performance Tips
- Lazy loading untuk images
- Pagination untuk large lists
- Debounce search input
- Minimize rebuilds dengan `const` widgets

### Printer Integration
- ESC/POS protocol untuk thermal printer
- Bluetooth printer support via `esc_pos_bluetooth`
- Network printer support via `esc_pos_utils`

---

*Last Updated: February 7, 2026*
*Version: 1.0.0*
