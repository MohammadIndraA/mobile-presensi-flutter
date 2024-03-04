import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_presence/app/models/GuruModel.dart';
import 'package:smart_presence/app/modules/Guru/controllers/guru_controller.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:smart_presence/widget/textForm.dart';
import '../../login/views/login_view.dart';
import '../controllers/profile_guru_controller.dart';

class ProfileGuruView extends GetView<ProfileGuruController> {
  final cont = Get.put(ProfileGuruController());
  final getGuru = Get.put(GuruController());
  ProfileGuruView({Key? key}) : super(key: key);
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
          future: getGuru.getDataGuru(),
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
            GuruModel guru = snap.data;
            cont.nisC.text = guru.nip;
            cont.namaC.text = guru.namaGuru;
            cont.telponC.text = guru.noWhatsapp;
            cont.alamatC.text = guru.alamatLengkap;

            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: textHome(
                    label: 'Update Profile',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                textForm(
                  controller: cont.nisC,
                  label: 'NIS',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                textForm(
                  controller: cont.namaC,
                  label: 'Nama',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                textForm(
                  controller: cont.telponC,
                  label: 'No Telepon',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                textForm(
                  controller: cont.alamatC,
                  label: 'Alamat',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      cont.updateProfileGuru();
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
                                'Update....',
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
          },
        ),
      ),
    );
  }
}
