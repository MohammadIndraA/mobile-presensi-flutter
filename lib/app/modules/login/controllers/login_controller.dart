import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController nisp = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  Future login() async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("${URL}login"),
        headers: {'Accept': 'application/json'},
        body: {'nisp': nisp.text, 'password': passC.text},
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        SpUtil.putString('nis', data['user']['nisp'] ?? '-');
        SpUtil.putString('token', data['token'] ?? '-');
        SpUtil.putString('level', data['user']['level'] ?? '-');
        if (data['user']['level'] == "Guru") {
          Get.toNamed(Routes.GURU);
        } else {
          Get.toNamed(Routes.HOME);
        }
        Get.snackbar('success', 'Berhasil Login');
      } else {
        isLoading.value = false;
        Get.snackbar('success', data['message']);
      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
      Get.snackbar('failed', 'Gagal Login');
    }
  }

  Future logout() async {
    try {
      SpUtil.clear();
      isLoading.value = true;
      Get.offAllNamed(Routes.LOGIN);
      nisp.clear();
      passC.clear();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('failed', 'Gagal Logout');
    }
  }
}
