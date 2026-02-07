# 🔧 Backend Setup Guide

## Prerequisites

Sebelum menjalankan aplikasi mobile RestoApp, pastikan backend RESTAUS sudah berjalan.

---

## 📋 Checklist

- [ ] Backend RESTAUS sudah di-clone/download
- [ ] MySQL server sudah running
- [ ] Database `restaus_db` sudah dibuat
- [ ] Node.js sudah terinstall
- [ ] Dependencies backend sudah terinstall

---

## 🚀 Cara Menjalankan Backend

### 1. Pastikan MySQL Running

```bash
# Check MySQL service
# Windows: Services.msc → MySQL
# Atau jalankan MySQL Workbench
```

### 2. Pastikan Database Exists

```sql
-- Buka MySQL Workbench atau command line
SHOW DATABASES LIKE 'restaus_db';

-- Jika belum ada, import schema
SOURCE /path/to/restaus/sql/query.sql;
SOURCE /path/to/restaus/sql/seed.sql;
```

### 3. Jalankan Backend Server

```bash
# Navigate ke folder backend RESTAUS
cd /path/to/restaus-backend

# Install dependencies (jika belum)
npm install

# Jalankan server
npm start
# atau
npm run dev

# Server akan berjalan di http://localhost:3000
```

### 4. Test Backend API

Buka browser atau Postman, test endpoint:

```
GET http://localhost:3000/api/menus
GET http://localhost:3000/api/categories
GET http://localhost:3000/api/tables
```

Jika berhasil, Anda akan melihat response JSON.

---

## 📱 Konfigurasi Mobile App

### Untuk Physical Device (HP Android/iOS)

**IP Address:** `192.168.1.7` (IP WiFi komputer Anda)

File: `lib/core/config/api_config.dart`
```dart
static const String wifiIpAddress = '192.168.1.7';
```

**Penting:**
- HP dan komputer harus terhubung ke WiFi yang sama
- Firewall Windows harus mengizinkan koneksi port 3000

### Untuk Android Emulator

File: `lib/core/config/api_config.dart`
```dart
static const String devBaseUrl = 'http://10.0.2.2:3000/api';
```

`10.0.2.2` adalah IP khusus untuk mengakses localhost dari Android emulator.

### Untuk iOS Simulator

File: `lib/core/config/api_config.dart`
```dart
static const String devBaseUrl = 'http://localhost:3000/api';
```

---

## 🔥 Firewall Configuration (Windows)

Jika menggunakan physical device, pastikan firewall mengizinkan koneksi:

### Option 1: Allow Node.js through Firewall

1. Open **Windows Defender Firewall**
2. Click **Allow an app through firewall**
3. Find **Node.js** atau **node.exe**
4. Check both **Private** and **Public** networks
5. Click **OK**

### Option 2: Create Inbound Rule

1. Open **Windows Defender Firewall with Advanced Security**
2. Click **Inbound Rules** → **New Rule**
3. Select **Port** → Next
4. Select **TCP** → Specific local ports: **3000**
5. Select **Allow the connection**
6. Check all profiles (Domain, Private, Public)
7. Name: "Node.js Backend Port 3000"
8. Click **Finish**

---

## 🧪 Testing Connection

### Test dari Browser (Komputer)

```
http://localhost:3000/api/menus
```

### Test dari HP (Physical Device)

```
http://192.168.1.7:3000/api/menus
```

Jika berhasil, Anda akan melihat data JSON.

---

## ❌ Troubleshooting

### Error: "Tidak ada koneksi internet"

**Penyebab:**
- Backend server tidak running
- IP address salah
- Firewall memblokir koneksi
- HP dan komputer tidak di WiFi yang sama

**Solusi:**
1. Pastikan backend running: `netstat -ano | findstr :3000`
2. Cek IP WiFi: `ipconfig` (Windows) atau `ifconfig` (Mac/Linux)
3. Update `api_config.dart` dengan IP yang benar
4. Disable firewall sementara untuk testing
5. Pastikan HP dan komputer di WiFi yang sama

### Error: "Connection refused"

**Solusi:**
- Pastikan backend server sudah running
- Cek port 3000 tidak digunakan aplikasi lain
- Restart backend server

### Error: "Timeout"

**Solusi:**
- Increase timeout di `api_config.dart`
- Cek koneksi internet/WiFi
- Pastikan backend tidak overload

---

## 📝 Quick Reference

| Device Type | Base URL |
|-------------|----------|
| Physical Device | `http://192.168.1.7:3000/api` |
| Android Emulator | `http://10.0.2.2:3000/api` |
| iOS Simulator | `http://localhost:3000/api` |
| Browser (Testing) | `http://localhost:3000/api` |

---

## 🔄 Restart Checklist

Jika ada masalah, restart semua:

1. ✅ Stop backend server (Ctrl+C)
2. ✅ Restart MySQL service
3. ✅ Start backend server (`npm start`)
4. ✅ Test di browser: `http://localhost:3000/api/menus`
5. ✅ Rebuild Flutter app: `flutter run`

---

**Last Updated:** February 7, 2026
