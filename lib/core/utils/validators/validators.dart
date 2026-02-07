/// Input validation utilities.
class Validators {
  Validators._();

  /// Validate username (not empty, min 3 chars).
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.trim().length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  /// Validate password (not empty, min 6 chars).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 5) {
      return 'Password minimal 5 karakter';
    }
    return null;
  }

  /// Validate required field.
  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  /// Validate numeric value.
  static String? validateNumeric(String? value, [String fieldName = 'Nilai']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName harus berupa angka';
    }
    return null;
  }

  /// Validate price (positive number).
  static String? validatePrice(String? value) {
    final numericError = validateNumeric(value, 'Harga');
    if (numericError != null) return numericError;

    final price = double.parse(value!);
    if (price <= 0) {
      return 'Harga harus lebih dari 0';
    }
    return null;
  }

  /// Validate quantity (positive integer).
  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Jumlah tidak boleh kosong';
    }
    final qty = int.tryParse(value);
    if (qty == null || qty <= 0) {
      return 'Jumlah harus bilangan positif';
    }
    return null;
  }
}
