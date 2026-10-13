import 'package:apk_analyzer/extensions/context_extensions.dart';
import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    this.onPressed,
    this.height = 52,
    this.width = 358,
    this.isLoading = false,
    this.icon,
    super.key,
  });
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final bool isLoading;
  final double width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        height: height.h,
        width: width.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20.sp,
                color: (isLoading || onPressed == null)
                    ? AppColors.textTertiary
                    : AppColors.background,
              ),
              SizedBox(width: AppSizes.sm),
            ],
            Text(
              isLoading ? "Analyzing..." : text,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: (isLoading || onPressed == null)
                    ? AppColors.textTertiary
                    : AppColors.background,
              ),
            ),
            if (isLoading) ...[
              SizedBox(width: AppSizes.md),
              SizedBox(
                height: AppSizes.md,
                width: AppSizes.md,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
