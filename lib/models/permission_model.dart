class PermissionInfo {
  final String name;
  final String description;
  final String risk; // high, sensitive, normal
  final String icon;

  PermissionInfo({
    required this.name,
    required this.description,
    required this.risk,
    required this.icon,
  });
}
