import 'package:get/get.dart';
import 'package:smart_presence/app/modules/login/controllers/login_controller.dart';
import 'package:smart_presence/app/pages/barcode.dart';
// import 'package:smart_presence/app/pages/presence.dart';
import 'package:smart_presence/app/pages/scanner.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

final cont = Get.put(LoginController());

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.LIST_MAPEL);
        break;
      case 2:
        if (SpUtil.getString('level') == "Siswa") {
          Get.offAll(() => const MyHomePage());
        } else {
          Get.offAll(() => const Barcode());
        }
        break;
      case 3:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        if (SpUtil.getString('level') == "Siswa") {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.GURU);
        }
    }
  }
}
