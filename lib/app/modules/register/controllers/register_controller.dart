import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/contans.dart';

class RegisterController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  RxString selectedValue = "".obs;
  RxString kelasValue = "".obs;
  RxString jurusanValue = "".obs;
  TextEditingController nisC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController namaOrtuC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController confirmC = TextEditingController();
  TextEditingController telponC = TextEditingController();
  TextEditingController telponOrtuC = TextEditingController();

  Future register() async {
    try {
      isLoading.value = true;
      var response = await http.post(Uri.parse("${URL}register"), headers: {
        'Accept': 'application/json',
      }, body: {
        'nis': nisC.text,
        'nama_lengkap': namaC.text,
        'no_telepon': telponC.text,
        'nama_ortu': namaOrtuC.text,
        'no_telepon_ortu': telponOrtuC.text,
        'alamat_lengkap': alamatC.text,
        'jenis_kelamin': selectedValue.value,
        'kelas': kelasValue.value,
        'jurusan': jurusanValue.value,
        'password_ex': passC.text,
      });
      var data = json.decode(response.body);
      isLoading.value = false;
      print('Ini STATUS NYA BROO ${response.statusCode}');
      if (response.statusCode == 201) {
        Get.snackbar('success', 'Silahkan Login');
        Get.toNamed(Routes.LOGIN);
      } else {
        isLoading.value = false;
        Get.snackbar('Gagal', data['message']);
        print(data['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Gagal', 'Gagaal Login');
    }
  }
}
