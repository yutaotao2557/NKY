import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sxd_method_channel.dart';

abstract class SxdPlatform extends PlatformInterface {
  /// Constructs a SxdPlatform.
  SxdPlatform() : super(token: _token);

  static final Object _token = Object();

  static SxdPlatform _instance = MethodChannelSxd();

  /// The default instance of [SxdPlatform] to use.
  ///
  /// Defaults to [MethodChannelSxd].
  static SxdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SxdPlatform] when
  /// they register themselves.
  static set instance(SxdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
