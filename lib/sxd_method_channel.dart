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
        Map<String, dynamic> map = {};
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", bytes)) as Map;
        Map<String, String> itemData = {};
        (back["data"] as Map).forEach((key, value) {
          itemData.addAll({"funCode": key.toString(), "data": value.toString()});
        });
        map.addAll({"commandId": 18, "msg": back["msg"], "code": 0, "data": itemData});
        return map;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> parse18(Uint8List hex) async {
    try {
      if (Platform.isAndroid) {
        var back = await methodChannel.invokeMethod('parserPro0x18', hex);
        Map<String, dynamic> map = {"commandId": 18, "code": 0};
        if (back.runtimeType.toString().toLowerCase().contains("bool")) map.addAll({"data": back as bool, "msg": "success"});
        if (back.runtimeType.toString().contains("string")) map.addAll({"data": back.toString(), "msg": back.toString()});
        return map;
      } else {
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", hex)) as Map;
        return {"commandId": 18, "data": back["msg"].contains("success"), "msg": "success", "code": 0};
      }
    } catch (e) {
      return {"commandId": 18, "data": false, "msg": "Parse Fail:$e", "code": -1};
    }
  }

  @override
  Future<dynamic> parse18ByOrigin(Uint8List hex) async {
    try {
      if (Platform.isAndroid) {
        return await methodChannel.invokeMethod('parserPro0x18', hex);
      } else {
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", hex));
        return back;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> parse19(Uint8List hex) async {
    try {
      if (Platform.isAndroid) {
        Map<String, dynamic> map = {"commandId": 19, "code": 0};
        var back = await methodChannel.invokeMethod('parserPro0x19', hex);
        List<Map<String, String>> itemData = [];
        (back as List).forEach((element) {
          var item = element as Map;
          itemData.add({"data": item["data"].toString(), "funCode": item["paramNo"].toString()});
        });
        map.addAll({"data": itemData, "code": 0});
        return map;
      } else {
        Map<String, dynamic> map = {};
        var back = (await methodChannel.invokeMapMethod("DeCodeWithInputData", hex)) as Map;
        List<Map<String, String>> itemData = [];
        (back["data"] as Map).forEach((key, value) {
          itemData.add({"funCode": key.toString(), "data": value.toString()});
        });
        map.addAll({"commandId": 19, "msg": back["msg"], "code": 0, "data": itemData});
        return map;
      }
    } catch (e) {
      return {"commandId": 19, "data": false, "msg": "Parse Fail:$e", "code": -1};
    }
  }

  @override
  Future<dynamic> parse19ByOrigin(Uint8List hex) async {
    try {
      if (Platform.isAndroid) {
        return await methodChannel.invokeMethod('parserPro0x19', hex);
      } else {
        return (await methodChannel.invokeMapMethod("DeCodeWithInputData", hex));
      }
    } catch (e) {
      return null;
    }
  }
}
