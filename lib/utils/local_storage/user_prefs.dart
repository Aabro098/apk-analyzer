import 'package:shared_preferences/shared_preferences.dart';

// Save user data
Future<void> saveUser({
  required String name,
  required String email,
  required String token,
  required String role,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  await prefs.setString('role', role);
  await prefs.setString('name', name);
  await prefs.setString('email', email);
}

Future<void> saveUserWithoutToken({
  required String name,
  required String email,
  required String role,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', role);
  await prefs.setString('name', name);
  await prefs.setString('email', email);
}

// Get user details
Future<Map<String, dynamic>> getDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return {
    'name': prefs.getString('name'),
    'email': prefs.getString('email'),
  };
}

Future<String?> getRole() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}

// Get user details
Future<String> getSecureToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  return token ?? '';
}

Future<void> storeSecureToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<void> recentSignIn({
  required bool recent,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('recent', recent);
}

Future<bool> getRecentSignIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('recent') ?? false;
}

Future<void> clearUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('name');
  await prefs.remove('email');
  await prefs.remove('auth_token');
  await prefs.remove('recent');
}

Future<String> getCode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final code = prefs.getString('selected_language');
  return code ?? '';
}

Future<void> isFirstOpen({
  required bool isFirst,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirst', isFirst);
}

Future<bool> getIsFirstOpen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirst') ?? false;
}
