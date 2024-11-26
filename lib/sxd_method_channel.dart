import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sxd_platform_interface.dart';

/// An implementation of [SxdPlatform] that uses method channels.
class MethodChannelSxd extends SxdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sxd');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
