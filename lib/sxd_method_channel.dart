import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sxd_platform_interface.dart';

/// An implementation of [SxdPlatform] that uses method channels.
class MethodChannelSxd extends SxdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sxd');

  @override
  Future<String?> getPlatformVersion() async => await methodChannel.invokeMethod<String>('getPlatformVersion');

  @override
  Future<dynamic> setDatalogerByP0x18(Map<String, dynamic> map) async => await methodChannel.invokeMethod<String>('setDatalogerByP0x18');

  @override
  Future<dynamic> parserPro0x18(String hex) async => await methodChannel.invokeMethod<String>('parserPro0x18');

  @override
  Future<dynamic> setDatalogerByP0x19(Map<String, dynamic> map) async => await methodChannel.invokeMethod<String>('setDatalogerByP0x19');

  @override
  Future<dynamic> parserPro0x19(String hex) async => await methodChannel.invokeMethod<String>('parserPro0x19');
}
