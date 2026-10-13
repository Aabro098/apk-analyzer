import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLocaleToSharedPreference(Locale newLocale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_language', newLocale.languageCode);
  await prefs.setString('selected_country', newLocale.countryCode ?? '');
}

Future<Locale> loadLocaleFromSharedPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('selected_language');
  String? countryCode = prefs.getString('selected_country');
  Locale locale = const Locale('en', 'US');
  if (languageCode != null) {
    locale = Locale(languageCode, countryCode);
  }
  return locale;
}
