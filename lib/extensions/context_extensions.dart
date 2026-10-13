import 'package:flutter/material.dart';
import 'package:apk_analyzer/utils/device/device_utility.dart';

/// Extension on [BuildContext] providing a shorthand method for localized string translation.
///
/// The [tr] method returns the localized string  using [AppLocalizations].
extension LocalizationExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);

  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  bool get isDarkMode => DeviceUtility.isDarkMode(this);
}
