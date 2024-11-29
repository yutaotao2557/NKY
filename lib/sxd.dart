import 'sxd_platform_interface.dart';

class Sxd {
  Future<String?> getPlatformVersion() => SxdPlatform.instance.getPlatformVersion();

  Future<List<int>?> setDatalogerByP0x18(Map<String, dynamic> map) async => await SxdPlatform.instance.setDatalogerByP0x18(map);

  dynamic parserPro0x18(String hex) => SxdPlatform.instance.parserPro0x18(hex);

  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map) async => await SxdPlatform.instance.setDatalogerByP0x19(map);

  dynamic parserPro0x19(String hex) => SxdPlatform.instance.parserPro0x19(hex);
}
