import 'package:get/get.dart';
import 'package:mine/proposal_controller.dart';

import 'background_video_controller.dart';

class ProposalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProposalController());
    Get.put(BackgroundVideoController());
  }
}
