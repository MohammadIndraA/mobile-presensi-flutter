import 'dart:convert';
import 'package:get/get.dart';
import 'package:smart_presence/app/models/UserModel.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

RxBool isLoading = false.obs;

// Rx<List<UserModel>> users = Rx<List<UserModel>>([]);
class HomeController extends GetxController {
  // @override
  // void onInit() {
  //   getData();
  //   print('usser : $users');
  //   super.onInit();
  // }
  Future getData() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("${URL}user/${SpUtil.getString('nis')}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SpUtil.getString('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final Map<String, dynamic> dataUser =
            json.decode(response.body)['user'];
        if (dataUser.isEmpty) {
          return [];
        } else {
          SpUtil.putString('jenisKelamin', dataUser['jenis_kelamin'] ?? '-');
          SpUtil.putString('nama', dataUser['nama_lengkap'] ?? '-');
          print(dataUser);
          return UserModel.fromJson(dataUser);
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body)['user']);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future getDataAbssen() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("${URL}user/data/${SpUtil.getString('nis')}"),
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
