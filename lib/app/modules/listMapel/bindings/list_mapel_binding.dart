import 'package:get/get.dart';

import '../controllers/list_mapel_controller.dart';

class ListMapelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMapelController>(
      () => ListMapelController(),
    );
  }
}
