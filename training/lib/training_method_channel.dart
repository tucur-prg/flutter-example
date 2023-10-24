import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'training_platform_interface.dart';

/// An implementation of [TrainingPlatform] that uses method channels.
class MethodChannelTraining extends TrainingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('training');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
