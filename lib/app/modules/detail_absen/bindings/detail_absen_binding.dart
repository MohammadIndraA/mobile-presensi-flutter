import 'package:get/get.dart';

import '../controllers/detail_absen_controller.dart';

class DetailAbsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAbsenController>(
      () => DetailAbsenController(),
    );
  }
}
