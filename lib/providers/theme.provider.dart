// import 'package:flutter/material.dart';
// import 'package:apk_analyzer/utils/theme/app_color_theme.dart';
// import '../utils/local_storage/theme_storage.dart';

// // *Using Provider for State management
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;
//   AppColorTheme _colorTheme = AppColorTheme.blue;

//   ThemeMode get themeMode => _themeMode;
//   AppColorTheme get colorTheme => _colorTheme;

//   /// Get the current primary color based on brightness
//   Color getPrimaryColor(Brightness brightness) {
//     return brightness == Brightness.dark
//         ? _colorTheme.primaryDark
//         : _colorTheme.primaryLight;
//   }

//   /// Get the current secondary color based on brightness
//   Color getSecondaryColor(Brightness brightness) {
//     return brightness == Brightness.dark
//         ? _colorTheme.secondaryDark
//         : _colorTheme.secondaryLight;
//   }

//   Future<void> loadTheme() async {
//     String? theme = await ThemeStorage.getTheme();
//     if (theme == 'light') {
//       _themeMode = ThemeMode.light;
//     } else if (theme == 'dark') {
//       _themeMode = ThemeMode.dark;
//     } else {
//       _themeMode = ThemeMode.system;
//     }

//     // Load color theme
//     String? colorTheme = await ThemeStorage.getColorTheme();
//     _colorTheme = AppColorThemeExtension.fromStorageString(colorTheme);

//     notifyListeners();
//   }

//   void setTheme(ThemeMode mode) {
//     _themeMode = mode;
//     ThemeStorage.setTheme(mode);
//     notifyListeners();
//   }

//   void setColorTheme(AppColorTheme colorTheme) {
//     _colorTheme = colorTheme;
//     ThemeStorage.setColorTheme(colorTheme.toStorageString());
//     notifyListeners();
//   }
// }
