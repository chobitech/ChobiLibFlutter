import 'package:flutter_test/flutter_test.dart';
import 'package:chobilib_flutter/chobilib_flutter.dart';
import 'package:chobilib_flutter/chobilib_flutter_platform_interface.dart';
import 'package:chobilib_flutter/chobilib_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockChobilibFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ChobilibFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ChobilibFlutterPlatform initialPlatform = ChobilibFlutterPlatform.instance;

  test('$MethodChannelChobilibFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelChobilibFlutter>());
  });

  test('getPlatformVersion', () async {
    ChobilibFlutter chobilibFlutterPlugin = ChobilibFlutter();
    MockChobilibFlutterPlatform fakePlatform = MockChobilibFlutterPlatform();
    ChobilibFlutterPlatform.instance = fakePlatform;

    expect(await chobilibFlutterPlugin.getPlatformVersion(), '42');
  });
}
