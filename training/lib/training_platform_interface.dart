import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'training_method_channel.dart';

abstract class TrainingPlatform extends PlatformInterface {
  /// Constructs a TrainingPlatform.
  TrainingPlatform() : super(token: _token);

  static final Object _token = Object();

  static TrainingPlatform _instance = MethodChannelTraining();

  /// The default instance of [TrainingPlatform] to use.
  ///
  /// Defaults to [MethodChannelTraining].
  static TrainingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TrainingPlatform] when
  /// they register themselves.
  static set instance(TrainingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
