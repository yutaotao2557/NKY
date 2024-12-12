import 'dart:typed_data';

import 'sxd_platform_interface.dart';

class Sxd {
  Future<String?> getPlatformVersion() => SxdPlatform.instance.getPlatformVersion();

  Future<Uint8List?> setDatalogerByP0x18(Map<String, dynamic> map) async {
    List<int>? back = await SxdPlatform.instance.setDatalogerByP0x18(map);
    return back == null ? null : Uint8List.fromList(back);
  }

  Future<Map<String, dynamic>> parse18(Uint8List bytes) => SxdPlatform.instance.parse18(bytes);

  Future<dynamic> parse18ByOrigin(Uint8List bytes) => SxdPlatform.instance.parse18ByOrigin(bytes);

  Future<Uint8List?> setDatalogerByP0x19(Map<String, dynamic> map) async {
    List<int>? back = await SxdPlatform.instance.setDatalogerByP0x19(map);
    return back == null ? null : Uint8List.fromList(back);
  }

  Future<Map<String, dynamic>> parse19(Uint8List bytes) => SxdPlatform.instance.parse19(bytes);

  Future<dynamic> parse19ByOrigin(Uint8List bytes) => SxdPlatform.instance.parse19ByOrigin(bytes);
}
