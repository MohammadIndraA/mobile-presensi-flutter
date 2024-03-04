import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/models/MapelModel.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class ListMapelController extends GetxController {
  List<MapelModel> dataAll = [];
  Future getData() async {
    try {
      var response = await http.get(
        Uri.parse("${URL}mapel/showDay"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        List dataMapel = (json.decode(response.body)
            as Map<String, dynamic>)['mata_pelajaran'];
        if (dataMapel.isEmpty) {
          return [];
        } else {
          dataAll = dataMapel.map((e) => MapelModel.fromJson(e)).toList();
          print(dataAll);
          return dataAll;
        }
      } else {
        Get.snackbar('failed', 'Gagal Menampilkan Jadwal pelajaran');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
