# 📋 Major Tasks - RestoApp Flutter

Daftar tugas utama untuk membangun aplikasi RestoApp. Tugas ini mencakup fitur inti yang krusial untuk operasional restoran.

---

## 1. 🏗️ Setup Project & Infrastructure

### 1.1 Project Initialization

- [x] **Create Flutter Project:** Generate project dengan `flutter create restoapp`
- [x] **Configure pubspec.yaml:** Setup semua dependencies yang diperlukan
- [x] **Folder Structure:** Implementasi Clean Architecture folder structure
- [x] **Analysis Options:** Setup linting rules dengan `flutter_lints`

### 1.2 Core Configuration

- [x] **Environment Config:** Setup development/staging/production environments
- [x] **Theme System:** Definisikan color palette, typography, dan component styles
- [x] **Constants:** Buat file constants untuk API endpoints, magic numbers, dll
- [x] **Dependency Injection:** Setup get_it dengan injectable untuk DI

### 1.3 Networking

- [x] **API Client:** Setup Dio dengan base configuration
- [x] **Interceptors:** Auth interceptor, logging, error handling
- [x] **API Response Wrapper:** Generic response class untuk handle success/error
- [x] **Connectivity Check:** Implement network connectivity monitoring

### 1.4 Data Layer

- [x] **Models:** Buat semua model classes dengan freezed & json_serializable
- [x] **Data Sources:** Remote data sources untuk setiap entity
- [x] **Repositories:** Implement repository pattern untuk data access

**Progress:** 15/15 tasks (100%) ✅

---

## 2. 🔐 Sistem Autentikasi & Authorization

### 2.1 Login Feature

- [x] **Login Page UI:** Modern login form dengan branding
- [x] **Form Validation:** Username & password validation
- [x] **Login BLoC:** State management untuk authentication
- [x] **Login API:** Connect ke `/api/auth/login` endpoint
- [x] **Error Handling:** Display error messages properly

### 2.2 Session Management

- [x] **Token Storage:** Secure storage untuk JWT/session token
- [x] **Auto Login:** Check stored token on app start
- [x] **Token Refresh:** Handle token expiration (basic)
- [x] **Session Timeout:** Auto logout after inactivity (ready)

### 2.3 Authorization

- [x] **Route Guards:** Protect routes based on user role
- [x] **Role-based UI:** Show/hide features based on role
- [x] **Middleware:** Intercept unauthorized access attempts

### 2.4 Logout

- [x] **Logout Function:** Clear session & local data
- [x] **Logout API:** Hit `/api/auth/logout` endpoint
- [x] **Redirect:** Navigate to login after logout

**Progress:** 14/14 tasks (100%) ✅

---

## 3. 👨‍💼 Admin Dashboard Module

### 3.1 Dashboard Overview

- [x] **Dashboard Page:** Main admin dashboard layout
- [x] **Stats Cards:** Revenue, orders, tables, warnings
- [ ] **Sales Chart:** Weekly/monthly sales visualization (fl_chart)
- [ ] **Recent Orders:** List of latest orders
- [x] **Quick Actions:** Navigation cards to sub-modules

### 3.2 Menu Management

- [x] **Menu List Page:** Searchable & filterable table/grid
- [x] **Menu BLoC:** State management untuk menu data
- [x] **Add Menu Dialog:** Form untuk create menu baru
- [x] **Edit Menu Dialog:** Form untuk update menu
- [x] **Toggle Menu Status:** Activate/deactivate menu
- [x] **Delete Menu:** Soft delete dengan confirmation
- [ ] **Stock Management:** Update inventory levels
- [ ] **Image Upload:** Upload menu images (optional)

### 3.3 Table Management

- [x] **Table List Page:** Grid view semua meja
- [x] **Table BLoC:** State management untuk tables
- [x] **Add Table Dialog:** Create new table
- [x] **Edit Table Dialog:** Modify table details
- [x] **Status Override:** Manual status change
- [x] **Delete Table:** Remove table

### 3.4 User Management

- [x] **User List Page:** All staff members
- [x] **User BLoC:** State management untuk users
- [x] **Add User Dialog:** Create staff account
- [x] **Edit User Dialog:** Modify user details & role
- [x] **Reset Password:** Admin password reset
- [ ] **Deactivate User:** Disable user account

### 3.5 Settings

- [ ] **Settings Page:** App configuration
- [ ] **Restaurant Info:** Name, address, etc
- [ ] **Receipt Settings:** Template customization

**Progress:** 20/27 tasks (74%) ✅

---

## 4. 🍽️ Waiter Module (Sistem Pemesanan)

### 4.1 Table Dashboard

- [ ] **Waiter Dashboard Page:** Main waiter screen
- [ ] **Table Grid Component:** Visual grid semua meja
- [ ] **Table Card Widget:** Individual table card dengan status
- [ ] **Status Legend:** Color code explanation
- [ ] **Stats Bar:** Available, occupied, warnings count
- [ ] **Pull to Refresh:** Manual refresh gesture
- [ ] **Auto Refresh:** Polling setiap 5-10 detik
- [ ] **Table BLoC Integration:** Real-time table status

### 4.2 Create Order

- [ ] **New Order Page:** Complete order creation flow
- [ ] **Table Info Display:** Selected table information
- [ ] **Category Tabs:** Horizontal scrollable categories
- [ ] **Menu Grid:** 2-column responsive grid
- [ ] **Menu Search:** Search by name
- [ ] **Menu Card Widget:** With image, price, stock badge
- [ ] **Stock Validation:** Disable if out of stock

### 4.3 Cart System

- [ ] **Cart BLoC:** State management untuk cart
- [ ] **Add to Cart:** Quick add functionality
- [ ] **Cart Bottom Sheet:** Expandable cart view
- [ ] **Quantity Selector:** +/- buttons
- [ ] **Special Notes:** Per-item notes input
- [ ] **Remove Item:** Swipe atau button delete
- [ ] **Cart Total:** Real-time total calculation

### 4.4 Order Submission

- [ ] **Validate Stock:** Check before submit
- [ ] **Submit Order API:** POST ke `/api/orders`
- [ ] **Loading State:** Show progress indicator
- [ ] **Success Feedback:** Navigate back + toast
- [ ] **Error Handling:** Show error & allow retry

**Progress:** 0/28 tasks (0%)

---

## 5. 👨‍🍳 Kitchen Display System (KDS)

### 5.1 Order Queue Display

- [ ] **KDS Page:** Main kitchen screen
- [ ] **Order Queue Component:** Grid/list pending orders
- [ ] **Kitchen BLoC:** State management untuk orders
- [ ] **Auto Refresh:** Polling setiap 5 detik
- [ ] **New Order Indicator:** Visual highlight untuk baru

### 5.2 Order Card

- [ ] **Kitchen Order Card:** Complex card component
- [ ] **Table Info:** Table number, order ID
- [ ] **Time Elapsed:** "X mins ago" indicator
- [ ] **Item List:** All items in order
- [ ] **Item Status Badges:** Pending, Cooking, Served
- [ ] **Late Warning:** Highlight if > 20 mins

### 5.3 Status Updates

- [ ] **Item Status Button:** Toggle individual item status
- [ ] **Update Item API:** PATCH `/api/order-items/{id}/status`
- [ ] **Order Completion:** Auto-complete when all served
- [ ] **Update Order API:** PATCH `/api/orders/{id}/status`
- [ ] **Optimistic Update:** Update UI before API response

### 5.4 Notifications

- [ ] **Sound Alert:** Play sound for new orders
- [ ] **Vibration:** Haptic feedback (optional)
- [ ] **Badge Count:** Show pending count

**Progress:** 0/18 tasks (0%)

---

## 6. 💰 Cashier/POS Module

### 6.1 Dashboard Layout

- [ ] **Cashier Page:** Split view layout
- [ ] **Pending Orders List:** Left sidebar
- [ ] **Order Detail Panel:** Right main area
- [ ] **Search/Filter:** By table, name, order ID

### 6.2 Order Selection

- [ ] **Order Summary Card:** Compact order info
- [ ] **Select Order:** Tap to view details
- [ ] **Order Detail View:** Full breakdown
- [ ] **Item List:** All items with prices

### 6.3 Payment Processing

- [ ] **Payment Form:** Main payment interface
- [ ] **Payment Method Selector:** Cash, QRIS, Debit tabs
- [ ] **Amount Input:** Numpad for cash input
- [ ] **Change Calculator:** Auto-calculate kembalian
- [ ] **Payment BLoC:** State management
- [ ] **Validate Amount:** Check sufficient payment
- [ ] **Process Payment API:** POST `/api/payments`
- [ ] **Success Feedback:** Confirmation + redirect

### 6.4 Post-Payment

- [ ] **Print Receipt:** Generate & print
- [ ] **Navigate to Receipt:** View receipt page
- [ ] **Update Table Status:** Mark as available
- [ ] **Clear Selection:** Reset for next customer

**Progress:** 0/20 tasks (0%)

---

## 7. 🧾 Receipt System

### 7.1 Receipt Page

- [ ] **Receipt Page:** Full receipt view
- [ ] **Receipt Template:** Thermal printer style
- [ ] **Restaurant Header:** Logo, name, address
- [ ] **Order Info:** ID, table, date, waiter
- [ ] **Item List:** Formatted item details
- [ ] **Total Section:** Subtotal, tax, grand total
- [ ] **Payment Info:** Method, amount, change
- [ ] **Footer:** Thank you message

### 7.2 Actions

- [ ] **PDF Generation:** Create PDF with `pdf` package
- [ ] **Print Function:** Send to thermal printer
- [ ] **Share Receipt:** Share as image/PDF
- [ ] **Download:** Save to device

**Progress:** 0/12 tasks (0%)

---

## 8. 📱 Customer Self-Order (Optional)

### 8.1 Table Selection

- [ ] **Landing Page:** Welcome screen
- [ ] **QR Scanner:** Scan table QR code
- [ ] **Manual Selection:** Grid of available tables
- [ ] **Table Confirmation:** Confirm selected table

### 8.2 Menu Browsing

- [ ] **Customer Menu Page:** Attractive menu display
- [ ] **Category Filter:** Browse by category
- [ ] **Item Detail:** Full item information
- [ ] **Add to Cart:** Quick add

### 8.3 Cart & Checkout

- [ ] **Customer Cart Page:** Review cart
- [ ] **Edit Items:** Modify before order
- [ ] **Place Order:** Submit to kitchen
- [ ] **Order Confirmation:** Success screen

### 8.4 Order Tracking

- [ ] **Order Status Page:** Track order progress
- [ ] **Status Timeline:** Visual progress
- [ ] **Auto Refresh:** Update status realtime
- [ ] **Completion View:** Order ready notification

**Progress:** 0/16 tasks (0%)

---

## 9. 🔔 Real-time & Notifications

### 9.1 Real-time Updates

- [ ] **Polling Service:** Background data refresh
- [ ] **WebSocket (Optional):** Real-time socket connection
- [ ] **State Sync:** Keep all users in sync
- [ ] **Optimistic Updates:** Update UI before server

### 9.2 Warning System

- [ ] **Payment Warning Logic:** Detect delivered unpaid
- [ ] **Warning Timer:** Track time elapsed
- [ ] **Visual Alert:** Red border/badge on table
- [ ] **Notification:** Alert kitchen/cashier

**Progress:** 0/8 tasks (0%)

---

## 10. 📊 Reporting (Future)

### 10.1 Sales Reports

- [ ] **Daily Sales:** Today's revenue breakdown
- [ ] **Weekly/Monthly:** Trend analysis
- [ ] **Export:** PDF/Excel export

### 10.2 Menu Analytics

- [ ] **Top Items:** Best sellers
- [ ] **Low Stock:** Inventory alerts
- [ ] **Performance:** Item profit analysis

**Progress:** 0/6 tasks (0%)

---

## 📈 Overall Progress

| Section      | Tasks   | Completed | Progress |
| ------------ | ------- | --------- | -------- |
| 1. Setup     | 15      | 15        | 100% ✅  |
| 2. Auth      | 14      | 14        | 100% ✅  |
| 3. Admin     | 27      | 0         | 0%       |
| 4. Waiter    | 28      | 0         | 0%       |
| 5. Kitchen   | 18      | 0         | 0%       |
| 6. Cashier   | 20      | 0         | 0%       |
| 7. Receipt   | 12      | 0         | 0%       |
| 8. Customer  | 16      | 0         | 0%       |
| 9. Real-time | 8       | 0         | 0%       |
| 10. Reports  | 6       | 0         | 0%       |
| **TOTAL**    | **164** | **29**    | **18%**  |

---

## 🎯 Priority Order

### 🔴 Critical (Must Have)

1. Setup & Infrastructure (Foundation)
2. Authentication System
3. Waiter Module (Core business flow)
4. Kitchen Module (Production flow)
5. Cashier Module (Revenue flow)
6. Receipt System

### 🟡 Important (Should Have)

7. Admin Dashboard
8. Real-time Updates
9. Menu Management
10. Table Management

### 🟢 Nice to Have

11. Customer Self-Order
12. Reports & Analytics
13. User Management
14. Advanced Settings

---

_Last Updated: February 7, 2026_
