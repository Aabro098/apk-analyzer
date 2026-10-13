// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:apk_analyzer/services/dio_client.dart';
// import 'package:apk_analyzer/utils/constants/api_constants.dart';

// class UserServices {
//   // Singleton instance
//   static final UserServices _instance = UserServices._internal();
//   factory UserServices() => _instance;
//   UserServices._internal();

//   Future<Map<String, dynamic>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final dio = await DioClient.initPublicClient();

//       final response = await dio.post(
//         UrlStrings.login,
//         data: FormData.fromMap({
//           'email': email,
//           'password': password,
//         }),
//       );

//       debugPrint('Login Response: ${response.data}');

//       return response.data;
//     } on DioException {
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>?> signupUser({
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String name,
//     required String address,
//     required String number,
//     required String? registrationNumber,
//     required File? disabilityCardFile,
//     required File? certificateFile,
//   }) async {
//     try {
//       final dio = await DioClient.initPublicClient();
//       final formData = FormData.fromMap({
//         'email': email,
//         'password': password,
//         'password_confirmation': confirmPassword,
//         'name': name,
//         'address': address,
//         'contact_number': number,
//         if (registrationNumber != null)
//           'registration_number': registrationNumber,
//         if (disabilityCardFile != null)
//           'disability_card': await MultipartFile.fromFile(
//             disabilityCardFile.path,
//             filename: disabilityCardFile.path.split('/').last,
//           ),
//         if (certificateFile != null)
//           'lawyer_certificate': await MultipartFile.fromFile(
//             certificateFile.path,
//             filename: certificateFile.path.split('/').last,
//           ),
//       });

//       final response = await dio.post(
//           disabilityCardFile != null
//               ? UrlStrings.userRegister
//               : UrlStrings.lawyerRegister,
//           data: formData);

//       debugPrint('Signup Response: ${response.data}');

//       return response.data;
//     } on DioException {
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>?> logout() async {
//     try {
//       final dio = await DioClient.initClient();

//       final response = await dio.post(
//         UrlStrings.logout,
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );
//       final Map<String, dynamic> data = response.data;

//       return data;
//     } on DioException {
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>?> changePassword({
//     required String role,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     try {
//       final dio = await DioClient.initClient();
//       final formData = FormData.fromMap({
//         'current_password': password,
//         'new_password': confirmPassword,
//         '_method': 'PUT',
//       });

//       final response = await dio.post('/$role/update-password', data: formData);

//       final data = response.data;

//       return data;
//     } on DioException {
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>?> requestChange({
//     required String email,
//   }) async {
//     try {
//       final dio = await DioClient.initClient();
//       final formData = FormData.fromMap({'email': email});

//       final response = await dio.post(UrlStrings.forgotPass, data: formData);

//       final Map<String, dynamic> data = response.data;

//       return data;
//     } on DioException {
//       rethrow;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>> fetchStatus() async {
//     try {
//       final dio = await DioClient.initClient();

//       final response = await dio.get(UrlStrings.statusCheck);
//       final Map<String, dynamic> data = response.data;
//       return data;
//     } on DioException {
//       rethrow;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
