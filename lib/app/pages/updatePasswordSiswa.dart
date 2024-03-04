import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:smart_presence/app/modules/login/views/login_view.dart';
import 'package:smart_presence/contans.dart';
import 'package:smart_presence/widget/textForm.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

final password = TextEditingController();
bool isLoading = false;

class UpdatePasswordSiswa extends StatefulWidget {
  const UpdatePasswordSiswa({super.key});
  @override
  State<UpdatePasswordSiswa> createState() => _UpdatePasswordSiswaState();
}

class _UpdatePasswordSiswaState extends State<UpdatePasswordSiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMART PRECENCE'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 200),
            const Center(
              child: textHome(
                  label: 'UPDATE PASSWORD',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            textForm(
              controller: password,
              label: 'Masukan Password',
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 12),
            if (SpUtil.getString('level') == "Siswa")
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      var response = await http.post(
                        Uri.parse(
                            "${URL}user/update-password/${SpUtil.getString('nis')}?_method=PUT"),
                        headers: {
                          'Accept': 'application/json',
                          'Authorization':
                              'Bearer ${SpUtil.getString('token')}',
                        },
                        body: {
                          'password': password.text,
                        },
                      );
                      var data = json.decode(response.body);
                      print(response.statusCode);
                      print(response.body);
                      if (response.statusCode == 200) {
                        Get.snackbar('success', 'Berhasil Update');
                        Get.to(() => const UpdatePasswordSiswa());
                      } else {
                        Get.snackbar('Gagal', data['message']);
                        print(data['message']);
                      }
                    } catch (e) {
                      print(e.toString());
                    } finally {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 73, 110),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: isLoading == true
                      ? const Text(
                          'Loading....',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            if (SpUtil.getString('level') == "Guru")
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      var response = await http.post(
                        Uri.parse(
                            "${URL}guru/updatePassword/${SpUtil.getString('nis')}?_method=PUT"),
                        headers: {
                          'Accept': 'application/json',
                          'Authorization':
                              'Bearer ${SpUtil.getString('token')}',
                        },
                        body: {
                          'password': password.text,
                        },
                      );
                      var data = json.decode(response.body);
                      print(response.statusCode);
                      print(response.body);
                      if (response.statusCode == 200) {
                        Get.snackbar('success', 'Berhasil Update');
                        Get.to(() => const UpdatePasswordSiswa());
                      } else {
                        Get.snackbar('Gagal', data['message']);
                        print(data['message']);
                      }
                    } catch (e) {
                      print(e.toString());
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 73, 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: isLoading == true
                      ? const Text(
                          'Loading....',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
