import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'background_video_controller.dart';
// Note: Is file ke liye tumhe BackgroundVideoController chahiye hoga
// Agar wo nahi hai to bata dena, main code de dunga.

class VideoBackground extends StatelessWidget {
  const VideoBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Agar controller global hai to Get.find karo, nahi to logic yaha likho
    // Filhal main assume kar raha hu tumne controller banaya hai
    try {
      final controller = Get.find<BackgroundVideoController>();

      return Obx(() {
        if (!controller.isReady.value || !controller.videoController.value.isInitialized) {
          return Container(color: Colors.black); // Jab tak load na ho Black screen
        }

        return SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.videoController.value.size.width,
              height: controller.videoController.value.size.height,
              child: VideoPlayer(controller.videoController),
            ),
          ),
        );
      });
    } catch (e) {
      return Container(color: Colors.black); // Fallback
    }
  }
}