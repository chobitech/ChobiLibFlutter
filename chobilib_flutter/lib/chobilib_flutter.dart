
import 'chobilib_flutter_platform_interface.dart';

class ChobilibFlutter {
  Future<String?> getPlatformVersion() {
    return ChobilibFlutterPlatform.instance.getPlatformVersion();
  }
}
