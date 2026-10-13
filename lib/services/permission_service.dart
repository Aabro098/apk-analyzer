import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:apk_analyzer/models/permission_model.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  late Map<String, PermissionInfo> _permissionMap;
  bool _isLoaded = false;

  factory PermissionService() {
    return _instance;
  }

  PermissionService._internal();

  Future<void> loadPermissions() async {
    if (_isLoaded) return;

    try {
      final String jsonString =
          await rootBundle.loadString('lib/utils/constants/permission.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);

      _permissionMap = {};
      for (var item in jsonList) {
        final permission = item['permission'] as String;
        final name = item['name'] as String;
        final description = item['description'] as String;
        final risk = item['risk'] as String;
        final icon = item['icon'] as String;

        _permissionMap[permission] = PermissionInfo(
          name: name,
          description: description,
          risk: risk,
          icon: icon,
        );
      }

      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load permissions: $e');
    }
  }

  PermissionInfo? getPermissionInfo(String permission) {
    return _permissionMap[permission];
  }

  List<PermissionInfo> mapPermissions(List<String> permissions) {
    return permissions
        .map((p) =>
            getPermissionInfo(p) ??
            PermissionInfo(
              name: p.split('.').last,
              description: 'Unknown permission',
              risk: 'UNKNOWN',
              icon: 'info',
            ))
        .toList();
  }
}
