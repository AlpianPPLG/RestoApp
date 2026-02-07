import 'package:intl/intl.dart';

/// Currency formatter utility.
class CurrencyFormatter {
  CurrencyFormatter._();

  static final _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final _formatterWithDecimal = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 2,
  );

  /// Format a number as Indonesian Rupiah (Rp 25.000).
  static String format(num amount) => _formatter.format(amount);

  /// Format with decimal places (Rp 25.000,00).
  static String formatWithDecimal(num amount) =>
      _formatterWithDecimal.format(amount);

  /// Format compact (25K, 2.5M).
  static String formatCompact(num amount) {
    if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return format(amount);
  }
}
