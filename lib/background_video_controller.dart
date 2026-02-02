import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideoController extends GetxController {
  late VideoPlayerController videoController;
  final isReady = false.obs;

  @override
  void onInit() {
    super.onInit();

    videoController = VideoPlayerController.asset(
      'assets/images/Roses_Flowers_and_Video.mp4',
    )..initialize().then((_) {
      videoController
        ..setLooping(true)
        ..setVolume(0.0)
        ..play();

      isReady.value = true;
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
