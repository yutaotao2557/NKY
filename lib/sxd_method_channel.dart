import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sxd_platform_interface.dart';

class MethodChannelSxd extends SxdPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('sxd');

  @override
  Future<String?> getPlatformVersion() async => await methodChannel.invokeMethod<String>('getPlatformVersion');

  @override
  Future<dynamic> setDatalogerByP0x18(Map<String, dynamic> map) async => await methodChannel.invokeMethod('setDatalogerByP0x18', map);

  @override
  Future<dynamic> parserPro0x18(String hex) async => await methodChannel.invokeMethod('parserPro0x18', hex);

  @override
  Future<dynamic> setDatalogerByP0x19(Map<String, dynamic> map) async => await methodChannel.invokeMethod('setDatalogerByP0x19', map);

  @override
  Future<dynamic> parserPro0x19(String hex) async => await methodChannel.invokeMethod('parserPro0x19', hex);
}
