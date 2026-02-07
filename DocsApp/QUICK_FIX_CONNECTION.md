# 🔧 Quick Fix - Connection Error

## Error yang Anda Alami

```
DioException [unknown]: null
Error: AppException: Tidak ada koneksi internet (code: null)
```

---

## ✅ Solusi Cepat (3 Langkah)

### 1️⃣ Jalankan Backend Server

```bash
# Buka terminal/command prompt
# Navigate ke folder backend RESTAUS
cd D:\path\to\restaus-backend

# Jalankan server
npm start
```

**Pastikan muncul:**
```
Server running on http://localhost:3000
Database connected successfully
```

---

### 2️⃣ Update API Config (Sudah Dilakukan ✅)

File: `lib/core/config/api_config.dart`

**Untuk Physical Device (HP Anda):**
```dart
static const bool useEmulator = false;  // ✅ Sudah diset
static const String wifiIpAddress = '192.168.1.7';  // ✅ IP WiFi Anda (Updated)
```

**Jika menggunakan Emulator:**
```dart
static const bool useEmulator = true;  // Ubah ke true
```

---

### 3️⃣ Allow Firewall (Windows)

**Quick Method:**
1. Tekan `Win + R`
2. Ketik: `firewall.cpl`
3. Klik **Allow an app through Windows Firewall**
4. Klik **Change settings**
5. Cari **Node.js** atau klik **Allow another app**
6. Browse ke: `C:\Program Files\nodejs\node.exe`
7. Centang **Private** dan **Public**
8. Klik **OK**

---

## 🧪 Test Connection

### Test 1: Dari Browser (Komputer)

Buka browser, akses:
```
http://localhost:3000/api/menus
```

**Expected:** Muncul data JSON

---

### Test 2: Dari HP

Buka browser di HP, akses:
```
http://192.168.1.7:3000/api/menus
```

**Expected:** Muncul data JSON yang sama

---

### Test 3: Dari Flutter App

1. Rebuild app: `flutter run`
2. Buka app di HP
3. Coba register/login

---

## 📱 Checklist Sebelum Test

- [ ] Backend server running (cek terminal ada log)
- [ ] MySQL service running
- [ ] HP dan komputer di WiFi yang sama
- [ ] Firewall sudah allow Node.js
- [ ] IP address di `api_config.dart` sudah benar
- [ ] Flutter app sudah di-rebuild

---

## 🔍 Debugging

### Cek Backend Running

```bash
# Windows
netstat -ano | findstr :3000

# Jika ada output, berarti server running
```

### Cek IP WiFi

```bash
ipconfig

# Cari "Wireless LAN adapter Wi-Fi"
# Lihat "IPv4 Address"
```

### Lihat Log API Config

Saat app running, cek console/logcat:
```
=================================
API Configuration
=================================
Environment: Development
Device Type: Physical Device
Base URL: http://192.168.1.7:3000/api
WiFi IP: 192.168.1.7
=================================
```

---

## ⚠️ Common Issues

### Issue 1: "Connection refused"
**Solusi:** Backend server belum running → Jalankan `npm start`

### Issue 2: "Timeout"
**Solusi:** Firewall blocking → Allow Node.js di firewall

### Issue 3: "Network unreachable"
**Solusi:** HP dan komputer beda WiFi → Sambungkan ke WiFi yang sama

### Issue 4: IP berubah
**Solusi:** 
1. Cek IP baru: `ipconfig`
2. Update `wifiIpAddress` di `api_config.dart`
3. Rebuild app: `flutter run`

---

## 🎯 Quick Commands

```bash
# 1. Cek IP
ipconfig

# 2. Cek port 3000
netstat -ano | findstr :3000

# 3. Test API dari browser
# http://192.168.1.7:3000/api/menus

# 4. Rebuild Flutter app
flutter run
```

---

## 📞 Still Not Working?

1. **Restart semua:**
   - Stop backend (Ctrl+C)
   - Restart MySQL
   - Start backend (`npm start`)
   - Rebuild Flutter app

2. **Disable firewall sementara** (untuk testing):
   - Windows Defender Firewall → Turn off
   - Test app
   - Turn on kembali setelah selesai

3. **Gunakan emulator** (alternatif):
   - Set `useEmulator = true` di `api_config.dart`
   - Jalankan Android emulator
   - Backend akan accessible via `10.0.2.2:3000`

---

**Last Updated:** February 7, 2026
