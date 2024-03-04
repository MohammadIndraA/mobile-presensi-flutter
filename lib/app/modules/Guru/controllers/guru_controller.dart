import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/models/GuruModel.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class GuruController extends GetxController {
  RxBool isLoading = false.obs;
  Future getDataGuru() async {
    try {
      isLoading.value = true;
      var respon = await http.get(
        Uri.parse('${URL}guru/showGuru/${SpUtil.getString('nis')}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      Map<String, dynamic> data = json.decode(respon.body)['guru'];
      if (respon.statusCode == 200) {
        if (data.isEmpty) {
          return [];
        } else {
          print(data);
          SpUtil.putString('nama_guru', data['nama_guru'] ?? '-');
          return GuruModel.fromJson(data);
        }
      } else {
        isLoading.value = false;
        Get.snackbar('Gagal', data['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getDataBarcode() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("${URL}barcode/data/${SpUtil.getString('nis')}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        List<dynamic>? dataUser = json.decode(response.body)['presensi'];
        if (dataUser == null) {
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
