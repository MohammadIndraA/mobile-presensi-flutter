import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class AbsenController extends GetxController {
  TextEditingController kelas = TextEditingController();
  TextEditingController mapel = TextEditingController();
  RxString val = "Pilih Kelas".obs;
  RxBool isLoading = false.obs;

  RxInt values = 0.obs;
  RxInt values1 = 0.obs;

  Future postBarcode() async {
    isLoading.value = true;
    try {
      var respon = await http.post(
          Uri.parse("${URL}barcode/create/${SpUtil.getString('nis')}"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SpUtil.getString('token')}',
          },
          body: {
            'mata_pelajaran_id': values1.value.toString(),
            'kelas_id': values.value.toString(),
          });
      var data = json.decode(respon.body);
      print(respon.statusCode);
      if (respon.statusCode == 200) {
        Get.snackbar('Success', data['message']);
      } else {
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Tidak dapat mmebuat barcode');
    } finally {
      isLoading.value = false;
    }
  }

  Future getKelas() async {
    try {
      var response = await http.get(
        Uri.parse("${URL}kelas"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['kelas'];
        if (data.isEmpty) {
          return [];
        } else {
          return data;
        }
      } else {
        Get.snackbar('failed', 'Gagal Menampilkan Jadwal pelajaran');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMapel() async {
    try {
      var response = await http.get(
        Uri.parse("${URL}mapel/showDay"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['mata_pelajaran'];
        if (data.isEmpty) {
          return [];
        } else {
          return data;
        }
      } else {
        Get.snackbar('failed', 'Gagal Menampilkan Jadwal pelajaran');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
