import 'package:intl/intl.dart';

/// Date & time formatting utility.
class DateFormatter {
  DateFormatter._();

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy HH:mm');
  static final _timeFormat = DateFormat('HH:mm');
  static final _receiptFormat = DateFormat('dd MMM yyyy HH:mm:ss');

  /// Format as date (07 Feb 2026).
  static String formatDate(DateTime dateTime) => _dateFormat.format(dateTime);

  /// Format as date and time (07 Feb 2026 14:30).
  static String formatDateTime(DateTime dateTime) =>
      _dateTimeFormat.format(dateTime);

  /// Format as time only (14:30).
  static String formatTime(DateTime dateTime) => _timeFormat.format(dateTime);

  /// Format for receipt (07 Feb 2026 14:30:00).
  static String formatReceipt(DateTime dateTime) =>
      _receiptFormat.format(dateTime);

  /// Time elapsed string ("X mins ago").
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'Baru saja';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam lalu';
    } else {
      return '${diff.inDays} hari lalu';
    }
  }

  /// Time elapsed in minutes.
  static int minutesAgo(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inMinutes;
  }
}
