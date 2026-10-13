import 'package:apk_analyzer/common/widgets/primary_button.dart';
import 'package:apk_analyzer/extensions/context_extensions.dart';
import 'package:apk_analyzer/models/permission_model.dart';
import 'package:apk_analyzer/services/permission_service.dart';
import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';
import 'package:apk_analyzer/utils/helpers/calculations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('apk_analyzer');
  final permissionService = PermissionService();

  bool _isLoading = false;
  String _appName = '';
  String _packageName = '';
  String _appLogo = '';
  List<PermissionInfo> permissions = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    try {
      await permissionService.loadPermissions();
    } catch (e) {
      debugPrint("Error loading permissions: $e");
    }
  }

  Future<void> pickAndAnalyzeApk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
    );

    if (result == null) return;

    if (mounted) {
      setState(() {
        _isLoading = true;
        permissions = [];
        _appName = '';
        _packageName = '';
        _appLogo = '';
        score = 0;
      });
    }

    String filePath = result.files.single.path!;

    try {
      // Get app name
      final String appName = await platform.invokeMethod('getAppName', {
        "apkPath": filePath,
      });

      // Get package name
      final String packageName = await platform.invokeMethod('getPackageName', {
        "apkPath": filePath,
      });

      // Get app logo
      final String appLogo = await platform.invokeMethod('getAppLogo', {
        "apkPath": filePath,
      });

      // Get permissions
      final List<dynamic> resultPermissions =
          await platform.invokeMethod('getPermissions', {
        "apkPath": filePath,
      });

      final List<String> permissionsList = resultPermissions.cast<String>();
      final List<PermissionInfo> mappedPermissions =
          permissionService.mapPermissions(permissionsList);

      if (mounted) {
        setState(() {
          _appName = appName;
          _packageName = packageName;
          _appLogo = appLogo;
          permissions = mappedPermissions;
          score = Calculations().calculateRiskScore(mappedPermissions);
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        setState(() {
          _appName = '';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.smMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSizes.smMd),
              AutoSizeText(
                'APK Analyzer',
                style: context.textTheme.headlineMedium
                    ?.copyWith(color: AppColors.primary),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: AppSizes.md),
              Container(
                padding: EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.withAlpha(82)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(42),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: AutoSizeText(
                  'Analyze APK files to detect sensitive permissions, identify risky behaviors, and stay informed about potential privacy and security threats.',
                  style: context.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSizes.md),
              PrimaryButton(
                onPressed: _isLoading ? null : pickAndAnalyzeApk,
                text: permissions.isNotEmpty
                    ? 'Analyze Another APK'
                    : 'Analyze APK',
                icon: Icons.add,
                isLoading: _isLoading,
              ),
              SizedBox(height: AppSizes.lg),
              if (_appName.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.sm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _getRiskLevelColor(score).withAlpha(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getRiskLevelColor(score).withAlpha(52),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (_appLogo.isNotEmpty)
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.grey[200],
                          ),
                          child: Image.memory(
                            Uri.parse('data:image/png;base64,$_appLogo')
                                .data!
                                .contentAsBytes(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      SizedBox(width: AppSizes.sm),
                      SizedBox(
                        width: 216.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _appName,
                              style: context.textTheme.titleMedium,
                            ),
                            Text(
                              _packageName,
                              style: context.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: AppSizes.lg,
                        height: AppSizes.lg,
                        child: CircularProgressIndicator(
                          value: score / 100,
                          strokeWidth: 6.w,
                          backgroundColor: Colors.grey.withAlpha(100),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getRiskLevelColor(score),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.md),
                    ],
                  ),
                ),
              SizedBox(height: AppSizes.smMd),
              if (permissions.isNotEmpty) ...[
                Builder(
                  builder: (context) {
                    final counts = _countPermissionsByRisk();
                    final riskData = [
                      (
                        'HIGH',
                        counts['HIGH'] ?? 0,
                        Colors.red,
                        Iconsax.warning_2
                      ),
                      (
                        'SENSITIVE',
                        counts['SENSITIVE'] ?? 0,
                        Colors.orange,
                        Iconsax.danger,
                      ),
                      (
                        'NORMAL',
                        counts['NORMAL'] ?? 0,
                        Colors.green,
                        Iconsax.shield_tick
                      ),
                      (
                        'UNKNOWN',
                        counts['UNKNOWN'] ?? 0,
                        Colors.grey,
                        Iconsax.information,
                      ),
                    ];

                    return SizedBox(
                      height: 38.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.xs),
                        itemCount: riskData.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: AppSizes.sm),
                        itemBuilder: (context, index) {
                          final (risk, count, color, icon) = riskData[index];
                          return _buildRiskCountCard(risk, count, color, icon);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.md),
              ],
              Expanded(
                child: ListView.separated(
                  itemCount: permissions.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: AppSizes.smMd);
                  },
                  itemBuilder: (context, index) {
                    final permission = permissions[index];
                    final riskColor = _getRiskColor(permission.risk);

                    return Container(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        AppSizes.sm,
                        AppSizes.sm,
                        AppSizes.sm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: riskColor.withAlpha(72),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: riskColor.withAlpha(25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: AppSizes.xs,
                            height: AppSizes.xl,
                            color: riskColor,
                          ),
                          SizedBox(width: AppSizes.sm),
                          SizedBox(
                            width: 224.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  permission.name,
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: AppSizes.xs),
                                Text(
                                  permission.description,
                                  style: context.textTheme.labelMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSizes.sm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.sm,
                              vertical: AppSizes.xs,
                            ),
                            decoration: BoxDecoration(
                              color: riskColor.withAlpha(52),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              permission.risk,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: riskColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk.toUpperCase()) {
      case 'HIGH':
        return Colors.red;
      case 'SENSITIVE':
        return Colors.orange;
      case 'UNKNOWN':
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color _getRiskLevelColor(int score) {
    if (score >= 80) {
      return Colors.red; // Critical
    } else if (score >= 50) {
      return Colors.orange; // High
    } else if (score >= 20) {
      return Colors.amber; // Medium
    } else {
      return Colors.green; // Low
    }
  }

  Map<String, int> _countPermissionsByRisk() {
    final counts = {
      'HIGH': 0,
      'SENSITIVE': 0,
      'NORMAL': 0,
      'UNKNOWN': 0,
    };

    for (var permission in permissions) {
      final risk = permission.risk.toUpperCase();
      if (counts.containsKey(risk)) {
        counts[risk] = counts[risk]! + 1;
      } else {
        counts['UNKNOWN'] = counts['UNKNOWN']! + 1;
      }
    }

    return counts;
  }

  Widget _buildRiskCountCard(
      String risk, int count, Color color, IconData icon) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: AppSizes.xs, horizontal: AppSizes.sm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: AppSizes.xs),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(width: AppSizes.xs),
          Text(
            risk,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
