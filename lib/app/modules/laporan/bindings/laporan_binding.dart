import 'package:get/get.dart';

import '../controllers/laporan_controller.dart';

class LaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanController>(
      () => LaporanController(),
    );
  }
}
