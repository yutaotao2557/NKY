import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sxd_platform_interface.dart';

class MethodChannelSxd extends SxdPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('sxd');

  @override
  Future<String?> getPlatformVersion() async => await methodChannel.invokeMethod<String>('getPlatformVersion');

  @override
  Future<List<int>?> setDatalogerByP0x18(Map<String, dynamic> map) async {
    try {
      if (Platform.isAndroid) {
        return (await methodChannel.invokeMethod('setDatalogerByP0x18', map)) as List<int>;
      } else {
        var back = (await methodChannel.invokeMapMethod("enCodeWithParams", map));
        return back?["data"] as List<int>;
      }
    } catch (e) {
      print("e:$e");
      return null;
    }
  }

  @override
  Future<dynamic> parserPro0x18(String hex) async => await methodChannel.invokeMethod('parserPro0x18', hex);

  @override
  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map) async {
    try {
      if (Platform.isAndroid) {
        return (await methodChannel.invokeMethod('setDatalogerByP0x19', map)) as List<int>;
      } else {
        var back = (await methodChannel.invokeMapMethod("enCodeWithParams", map));
        print(back);
        //{result: 0, msg: Data packaging successful, data: [0, 24, 0, 6, 0, 16, 1, 25, 203, 212, 72, 186, 152, 152, 95, 115, 211, 206, 100, 76, 21, 150, 151, 176, 108, 146]}
        return back?["data"] as List<int>;
      }
    } catch (e) {
      print("e:$e");
      return null;
    }
  }

  @override
  Future<dynamic> parserPro0x19(String hex) async => await methodChannel.invokeMethod('parserPro0x19', hex);
}
