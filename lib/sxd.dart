
import 'sxd_platform_interface.dart';

class Sxd {
  Future<String?> getPlatformVersion() {
    return SxdPlatform.instance.getPlatformVersion();
  }
}
