import 'dart:async';

import 'package:chobilib_flutter/permission/permission_request_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


mixin PermissionCheckableMixin<T extends StatefulWidget> on State<T> {

  Future<void> checkAndRequestPermission(
      PermissionRequestData requestData, {
        void Function()? onPermissionGranted,
        void Function()? onPermissionDenied,
        void Function()? onPermissionPermanentDenied,
      }
  ) async {
    final target = Permission.byValue(requestData.permissionValue);
    final status = await target.status;

    if (status.isGranted) {
      onPermissionGranted?.call();
    } else if (status.isDenied) {
      final reqRes = await target.request();

      if (reqRes.isGranted) {
        onPermissionGranted?.call();
      } else if (reqRes.isPermanentlyDenied) {
        onPermissionPermanentDenied?.call();
      } else {
        onPermissionDenied?.call();
      }
    } else if (status.isPermanentlyDenied) {
      onPermissionPermanentDenied?.call();
    }
  }
}