import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;

  RxString kelasValue = "".obs;
  TextEditingController nisC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController telponC = TextEditingController();
  TextEditingController telponOrtuC = TextEditingController();
  TextEditingController namaOrtuC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  Future updateProfile() async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("${URL}user/update/${SpUtil.getString('nis')}?_method=PUT"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
        body: {
          'nama_lengkap': namaC.text,
          'no_telepon': telponC.text,
          'nama_ortu': namaOrtuC.text,
          'no_telepon_ortu': telponOrtuC.text,
          'alamat_lengkap': alamatC.text,
          'kelas': kelasValue.value,
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar('success', 'Update berhasil');
        Get.toNamed(Routes.UPDATE_PROFILE);
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
