import 'package:get/get.dart';

import '../controllers/profile_guru_controller.dart';

class ProfileGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileGuruController>(
      () => ProfileGuruController(),
    );
  }
}
