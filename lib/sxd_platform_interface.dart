import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sxd_method_channel.dart';

abstract class SxdPlatform extends PlatformInterface {
  SxdPlatform() : super(token: _token);

  static final Object _token = Object();

  static SxdPlatform _instance = MethodChannelSxd();

  static SxdPlatform get instance => _instance;

  static set instance(SxdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<int>?> setDatalogerByP0x18(Map<String, dynamic> map);

  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map);

  /// 解析指令18的数据，进行二次封装，返回Map类型数据
  Future<Map<String, dynamic>> parse18(Uint8List hex);

  /// 解析指令18的数据，直接返回原生解析的数据，不进行二次封装
  Future<dynamic> parse18ByOrigin(Uint8List hex);

  /// 解析指令19的数据，进行二次封装，返回Map类型数据
  Future<Map<String, dynamic>> parse19(Uint8List hex);

  /// 解析指令19的数据，直接返回原生解析的数据，不进行二次封装
  Future<dynamic> parse19ByOrigin(Uint8List hex);
}
