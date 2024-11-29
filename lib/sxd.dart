import 'dart:typed_data';

import 'sxd_platform_interface.dart';

class Sxd {
  Future<String?> getPlatformVersion() => SxdPlatform.instance.getPlatformVersion();

  Future<Uint8List?> setDatalogerByP0x18(Map<String, dynamic> map) async {
    List<int>? back = await SxdPlatform.instance.setDatalogerByP0x18(map);
    return back == null ? null : Uint8List.fromList(back);
  }

  dynamic parserPro0x18(Uint8List bytes) => SxdPlatform.instance.parserPro0x18(bytes);

  Future<Uint8List?> setDatalogerByP0x19(Map<String, dynamic> map) async {
    List<int>? back = await SxdPlatform.instance.setDatalogerByP0x19(map);
    return back == null ? null : Uint8List.fromList(back);
  }

  dynamic parserPro0x19(Uint8List bytes) => SxdPlatform.instance.parserPro0x19(bytes);
}
