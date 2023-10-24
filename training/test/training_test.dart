import 'package:flutter_test/flutter_test.dart';
import 'package:training/src/training.dart';
import 'package:training/src/training_platform_interface.dart';
import 'package:training/src/training_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTrainingPlatform
    with MockPlatformInterfaceMixin
    implements TrainingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TrainingPlatform initialPlatform = TrainingPlatform.instance;

  test('$MethodChannelTraining is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTraining>());
  });

  test('getPlatformVersion', () async {
    Training trainingPlugin = Training();
    MockTrainingPlatform fakePlatform = MockTrainingPlatform();
    TrainingPlatform.instance = fakePlatform;

    expect(await trainingPlugin.getPlatformVersion(), '42');
  });
}
