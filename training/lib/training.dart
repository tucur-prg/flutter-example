
import 'training_platform_interface.dart';

class Training {
  Future<String?> getPlatformVersion() {
    return TrainingPlatform.instance.getPlatformVersion();
  }
}
