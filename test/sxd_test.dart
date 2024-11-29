import 'package:flutter_test/flutter_test.dart';
import 'package:sxd/sxd.dart';
import 'package:sxd/sxd_platform_interface.dart';
import 'package:sxd/sxd_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSxdPlatform with MockPlatformInterfaceMixin implements SxdPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future parserPro0x18(String hex) => Future.value("parserPro0x18");

  @override
  Future parserPro0x19(String hex) => Future.value("parserPro0x19");

  @override
  Future<List<int>?> setDatalogerByP0x18(Map<String, dynamic> map) => Future.value([]);

  @override
  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map) => Future.value([]);
}

void main() {
  final SxdPlatform initialPlatform = SxdPlatform.instance;

  test('$MethodChannelSxd is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSxd>());
  });

  test('getPlatformVersion', () async {
    Sxd sxdPlugin = Sxd();
    MockSxdPlatform fakePlatform = MockSxdPlatform();
    SxdPlatform.instance = fakePlatform;

    expect(await sxdPlugin.getPlatformVersion(), '42');
  });
}
