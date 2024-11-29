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
      // print("e:$e");
      return null;
    }
  }

  @override
  Future<dynamic> parserPro0x18(Uint8List bytes) async {
    try {
      if (Platform.isAndroid) {
        return await methodChannel.invokeMethod('parserPro0x18', bytes);
      } else {
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", bytes));
        return back;
      }
    } catch (e) {
      // print("e:$e");
      return null;
    }
  }

  @override
  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map) async {
    try {
      if (Platform.isAndroid) {
        return (await methodChannel.invokeMethod('setDatalogerByP0x19', map)) as List<int>;
      } else {
        var back = (await methodChannel.invokeMapMethod("enCodeWithParams", map));
        return back?["data"] as List<int>;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<dynamic> parserPro0x19(Uint8List bytes) async {
    try {
      if (Platform.isAndroid) {
        return await methodChannel.invokeMethod('parserPro0x19', bytes);
      } else {
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", bytes));
        return back;
      }
    } catch (e) {
      // print("e:$e");
      return null;
    }
  }
}
