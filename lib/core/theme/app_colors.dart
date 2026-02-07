import 'package:flutter/material.dart';

/// Application color palette.
///
/// Matches the web app's orange-themed design system.
class AppColors {
  AppColors._();

  // Primary Colors (Orange theme)
  static const primary = Color(0xFFF97316); // Orange 500
  static const primaryDark = Color(0xFFEA580C); // Orange 600
  static const primaryLight = Color(0xFFFB923C); // Orange 400

  // Accent
  static const accent = Color(0xFFD97706); // Amber 600

  // Status Colors
  static const success = Color(0xFF22C55E); // Green 500
  static const warning = Color(0xFFEAB308); // Yellow 500
  static const error = Color(0xFFEF4444); // Red 500
  static const info = Color(0xFF3B82F6); // Blue 500

  // Table Status Colors
  static const tableAvailable = Color(0xFF22C55E); // Green
  static const tableOccupied = Color(0xFF3B82F6); // Blue
  static const tableReserved = Color(0xFFEAB308); // Yellow
  static const tableWarning = Color(0xFFEF4444); // Red

  // Neutral Colors
  static const background = Color(0xFFFFF7ED); // Orange 50
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111827); // Gray 900
  static const textSecondary = Color(0xFF6B7280); // Gray 500
  static const border = Color(0xFFE5E7EB); // Gray 200
  static const divider = Color(0xFFF3F4F6); // Gray 100

  // Dark Mode
  static const darkBackground = Color(0xFF111827);
  static const darkSurface = Color(0xFF1F2937);
  static const darkBorder = Color(0xFF374151);
}
