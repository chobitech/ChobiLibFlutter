import 'dart:async';

import 'package:chobilib_flutter/permission/permission_request_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


class PermissionCheckProcesses {

  final PermissionRequestData requestData;

  final void Function(PermissionCheckProcesses processes)? onGranted;
  final void Function(PermissionCheckProcesses processes)? onDenied;
  final void Function(PermissionCheckProcesses processes)? onPermanentlyDenied;

  PermissionCheckProcesses({
    required this.requestData,
    this.onGranted,
    this.onDenied,
    this.onPermanentlyDenied,
  });
}


mixin PermissionCheckableMixin<T extends StatefulWidget> on State<T> {

  Future<void> checkAndRequestPermissionWithProcesses(PermissionCheckProcesses processes) async {
    await checkAndRequestPermission(
      processes.requestData,
      onPermissionGranted: () => processes.onGranted?.call(processes),
      onPermissionDenied: () => processes.onDenied?.call(processes),
      onPermissionPermanentDenied: () => processes.onPermanentlyDenied?.call(processes),
    );
  }

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