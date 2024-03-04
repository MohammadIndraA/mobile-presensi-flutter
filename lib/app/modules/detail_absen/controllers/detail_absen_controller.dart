import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class DetailAbsenController extends GetxController {
  RxBool isLoading = false.obs;
  Future getDataAbssen() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("${URL}user/thisWeeks/${SpUtil.getString('nis')}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> dataUser = json.decode(response.body);
        if (dataUser.isEmpty) {
          return [];
        } else {
          return dataUser;
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
