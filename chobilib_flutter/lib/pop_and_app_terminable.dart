import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef PopAndAppTerminableOnPopEventProvider = StateProvider<FutureOr<void> Function()?>;


class PopAndAppTerminable extends StatefulWidget {

  static PopAndAppTerminableOnPopEventProvider createEmptyProvider() => PopAndAppTerminableOnPopEventProvider((ref) => null);

  final int intervalMilliSecToExitApp;
  final FutureOr<void> Function(BuildContext context)? beforePopToExit;
  final PopAndAppTerminableOnPopEventProvider? onPopEventProvider;
  final Widget child;

  const PopAndAppTerminable({super.key, this.intervalMilliSecToExitApp = 2000, this.beforePopToExit, this.onPopEventProvider, required this.child,});

  @override
  State<PopAndAppTerminable> createState() => _PopAndAppTerminableState();
}

class _PopAndAppTerminableState extends State<PopAndAppTerminable> {

  int _lastBackKeyClickedTime = 0;

  late final PopAndAppTerminableOnPopEventProvider _onPopEventProvider;

  @override
  void initState() {
    super.initState();

    _onPopEventProvider = widget.onPopEventProvider ?? PopAndAppTerminableOnPopEventProvider((ref) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (b) async {
            final f = ref.read(widget.onPopEventProvider!);
            if (f != null) {
              await f();
            } else {
              if (Platform.isAndroid) {
                final cTime = DateTime.now().millisecondsSinceEpoch;
                if (cTime - _lastBackKeyClickedTime > widget.intervalMilliSecToExitApp) {
                  _lastBackKeyClickedTime = cTime;
                  await widget.beforePopToExit?.call(context);
                } else {
                  SystemNavigator.pop();
                }
              }
            }
          },
          child: child!,
        );
      },
      child: widget.child,
    );
  }

}
