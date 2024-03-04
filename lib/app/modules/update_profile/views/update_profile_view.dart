import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_presence/app/models/UserModel.dart';
import 'package:smart_presence/app/modules/home/controllers/home_controller.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:smart_presence/app/modules/login/views/login_view.dart';
import 'package:smart_presence/widget/textForm.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(UpdateProfileController());
  final cont = Get.put(HomeController());
  List<DropdownMenuItem<String>> get kelasItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "I", child: Text("I")),
      const DropdownMenuItem(value: "II", child: Text("II")),
      const DropdownMenuItem(value: "III", child: Text("III")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMART PRESENT'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: FutureBuilder(
            future: cont.getData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snap.hasData) {
                return const Center(
                  child: Text('Tidak Ada Data'),
                );
              }
              UserModel user = snap.data;
              controller.nisC.text = user.nis;
              var kelas = user.kelas;
              controller.namaC.text = user.namaLengkap;
              controller.telponC.text = user.noTelepon;
              controller.namaOrtuC.text = user.namaOrtu;
              controller.alamatC.text = user.alamatLengkap;
              controller.telponOrtuC.text = user.noTeleponOrtu;

              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: textHome(
                      label: 'Update Profile',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  textForm(
                    controller: controller.nisC,
                    label: 'NIS',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  textForm(
                    controller: controller.namaC,
                    label: 'Nama',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    hint: const Text(
                      'Kelas',
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: kelas,
                    onChanged: (String? newValue) {
                      controller.kelasValue(
                        newValue,
                      );
                      print(controller.kelasValue.value);
                    },
                    items: kelasItems,
                  ),
                  const SizedBox(height: 12),
                  textForm(
                    controller: controller.telponC,
                    label: 'No Telepon',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  textForm(
                    controller: controller.alamatC,
                    label: 'Alamat',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  textForm(
                    controller: controller.namaOrtuC,
                    label: 'Nama Orang tua',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  textForm(
                    controller: controller.telponOrtuC,
                    label: 'No Telepon Orang tua',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        controller.updateProfile();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Obx(
                        () {
                          return controller.isLoading.value
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
                                );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
