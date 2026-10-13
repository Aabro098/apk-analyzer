import 'package:apk_analyzer/models/permission_model.dart';

class Calculations {
  final riskWeights = {
    "HIGH": 15,
    "SENSITIVE": 8,
    "NORMAL": 2,
  };

  int calculateBaseScore(List<PermissionInfo> permissions) {
    int score = 0;

    for (var p in permissions) {
      score += riskWeights[p.risk] ?? 1;
    }

    return score;
  }

  int applyHeuristics(List<String> perms, int score) {
    bool hasSMS = perms.contains("android.permission.READ_SMS") ||
        perms.contains("android.permission.SEND_SMS");

    bool hasInternet = perms.contains("android.permission.INTERNET");

    bool hasOverlay = perms.contains("android.permission.SYSTEM_ALERT_WINDOW");

    bool hasInstall =
        perms.contains("android.permission.REQUEST_INSTALL_PACKAGES");

    bool hasBoot = perms.contains("android.permission.RECEIVE_BOOT_COMPLETED");

    // 🚨 Data exfiltration pattern
    if (hasSMS && hasInternet) {
      score += 25;
    }

    // 🚨 Overlay attack
    if (hasOverlay) {
      score += 20;
    }

    // 🚨 Persistence + control
    if (hasBoot && hasInternet) {
      score += 15;
    }

    // 🚨 Malware installer behavior
    if (hasInstall) {
      score += 25;
    }

    return score;
  }

  int normalizeScore(int score) {
    if (score > 100) return 100;
    return score;
  }

  int calculateRiskScore(List<PermissionInfo> permissions) {
    final perms = permissions.map((e) => e.name).toList();

    int score = calculateBaseScore(permissions);
    score = applyHeuristics(perms, score);

    return normalizeScore(score);
  }
}
