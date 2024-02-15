import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestData {

  final int permissionValue;
  final String label;
  final IconData? iconData;

  Permission get permission => Permission.byValue(permissionValue);

  PermissionRequestData({required this.permissionValue, required this.label, this.iconData,});

}
