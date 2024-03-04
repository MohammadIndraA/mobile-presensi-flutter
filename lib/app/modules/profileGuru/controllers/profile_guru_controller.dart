import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class ProfileGuruController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nisC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController telponC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  Future updateProfileGuru() async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("${URL}guru/update/${SpUtil.getString('nis')}?_method=PUT"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
        body: {
          'nama_guru': namaC.text,
          'no_whatsapp': telponC.text,
          'alamat_lengkap': alamatC.text,
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar('success', 'Berhasil Update');
        Get.toNamed(Routes.PROFILE_GURU);
      } else {
        isLoading.value = false;
        Get.snackbar('Gagal', data['message']);
        print(data['message']);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Gagal', 'Gagal Update');
    } finally {
      isLoading.value = false;
    }
  }
}
