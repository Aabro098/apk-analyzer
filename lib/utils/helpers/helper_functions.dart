import 'package:apk_analyzer/common/widgets/custom_snackbar.dart';
import 'package:apk_analyzer/utils/helpers/app_globals.dart';
import 'package:flutter/material.dart';

/// Displays an error [SnackBar] with the given [message].
///
/// Optionally, you can specify the display [time] in milliseconds (default is 1000).
/// If [actionMethod] and [actionLabel] are provided, an action button will be shown
/// in the [SnackBar] that triggers [actionMethod] when pressed.
///
/// The [SnackBar] uses [AppColors.error] as its background color and applies
/// padding using [AppSizes.sm] and [AppSizes.md].
///
/// Removes any currently displayed [SnackBar] before showing the new one.
///
/// Example usage:
/// ```dart
/// showErrorSnackbar('An error occurred');
/// showErrorSnackbar(
///   'Failed to save',
///   actionLabel: 'Retry',
///   actionMethod: () { /* retry logic */ },
/// );
/// ```
/// Requires [scaffoldMessengerKey] to be properly initialized and accessible.
// void showErrorSnackbar(String message) {
//   scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
//   scaffoldMessengerKey.currentState?.showSnackBar(
//     SnackBar(
//       backgroundColor: AppColors.error,
//       duration: const Duration(seconds: 2),
//       padding: EdgeInsets.symmetric(
//         vertical: AppSizes.md,
//         horizontal: AppSizes.md,
//       ),
//       content: Text(
//         scaffoldMessengerKey.currentContext?.tr(message) ?? message,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 14.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   );
// }

void showErrorSnackbar(
  String message, {
  BuildContext? context,
}) {
  TopSnackbar.show(
    navigatorKey.currentContext!,
    TopSnackbar.error(message),
  );
}

/// Displays a success [SnackBar] with the given [message].
///
/// Optionally, you can specify the display [time] in milliseconds (default is 1000).
/// If [actionMethod] and [actionLabel] are provided, an action button will be shown in the snackbar.
///
/// Before showing the new snackbar, any currently displayed snackbar will be hidden.
///
/// Example usage:
/// ```dart
/// showSuccessSnackbar('Operation successful');
/// showSuccessSnackbar(
///   'Item deleted',
///   actionLabel: 'UNDO',
///   actionMethod: () { /* undo logic */ },
/// );
/// ```
///
/// Requires [scaffoldMessengerKey] to be properly initialized and accessible.
// void showSuccessSnackbar(
//   String message, {
//   VoidCallback? onAction,
//   String? actionLabel,
// }) {
//   // Remove existing snackbar if any
//   scaffoldMessengerKey.currentState?.removeCurrentSnackBar();

//   // Show persistent snackbar until OK is tapped
//   scaffoldMessengerKey.currentState?.showSnackBar(
//     SnackBar(
//       backgroundColor: Colors.green,
//       duration: const Duration(seconds: 2), // practically infinite
//       padding: EdgeInsets.symmetric(
//         vertical: AppSizes.md,
//         horizontal: AppSizes.md,
//       ),
//       content: Text(
//         scaffoldMessengerKey.currentContext?.tr(message) ?? message,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 14.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   );
// }

void showSuccessSnackbar(
  String message, {
  BuildContext? context,
}) {
  TopSnackbar.show(
    navigatorKey.currentContext!,
    TopSnackbar.success(message),
  );
}
