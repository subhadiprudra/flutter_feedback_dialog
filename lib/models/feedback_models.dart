import 'dart:io';
import 'package:flutter/material.dart';

// --- Enums --
enum CommunicationTheme { light, dark }

class CommunicationResponse {
  final String message;
  String? email;
  List<File> screenshots;

  CommunicationResponse({
    required this.message,
    this.email,
    required this.screenshots,
  });
}

// --- Configuration Classes ---
class TypeConfig {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final String placeholder;
  final String submitText;
  final String successTitle;
  final String successMessage;
  final List<Color> lightGradientColors;
  final List<Color> darkGradientColors;

  TypeConfig({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.placeholder,
    required this.submitText,
    required this.successTitle,
    required this.successMessage,
    required this.lightGradientColors,
    required this.darkGradientColors,
  });
}

class ThemeStyles {
  final Color backgroundStart;
  final Color backgroundMiddle;
  final Color backgroundEnd;
  final Color dialogBg;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color inputBg;
  final Color inputBorder;
  final Color inputFocusRing;
  final Color uploadBorder;
  final Color uploadHoverBorder;
  final Color closeHoverBg;
  final Color overlayColor;

  ThemeStyles({
    required this.backgroundStart,
    required this.backgroundMiddle,
    required this.backgroundEnd,
    required this.dialogBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.inputBg,
    required this.inputBorder,
    required this.inputFocusRing,
    required this.uploadBorder,
    required this.uploadHoverBorder,
    required this.closeHoverBg,
    required this.overlayColor,
  });
}
