import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/widget/textButtom.dart';
import 'package:smart_presence/widget/textForm.dart';

import '../controllers/register_controller.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "L", child: Text("Laki-Laki")),
    const DropdownMenuItem(value: "P", child: Text("Perempuan")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get kelasItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "I", child: Text("I")),
    const DropdownMenuItem(value: "II", child: Text("II")),
    const DropdownMenuItem(value: "III", child: Text("III")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get jurusanItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
        value: "OTKP", child: Text("OTOMATISASI PERKANTORAN")),
    const DropdownMenuItem(
        value: "TKJ", child: Text("TEKNIK KOMPUTER JARINGAN")),
    const DropdownMenuItem(value: "TB", child: Text("TATA BOGA")),
    const DropdownMenuItem(value: "TSM", child: Text("TEKNIK SEPEDA MOTOR")),
    const DropdownMenuItem(
        value: "RPL", child: Text("REKAYASA PERANGKAT LUNAK")),
  ];
  return menuItems;
}

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 40),
            Text(
              'Registrasi',
              style: GoogleFonts.urbanist(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 17),
            textForm(
              controller: controller.nisC,
              label: 'NIS',
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            textForm(
              controller: controller.namaC,
              label: 'Nama',
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            textForm(
              controller: controller.telponC,
              label: 'No Telepon',
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            textForm(
              controller: controller.alamatC,
              label: 'Alamat',
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            textForm(
              controller: controller.namaOrtuC,
              label: 'Nama Orang tua',
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            textForm(
              controller: controller.telponOrtuC,
              label: 'No Telepon Orang tua',
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              hint: const Text(
                'Jenis Kelaminn',
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // value: controller.selectedValue.value,
              onChanged: (String? newValue) {
                controller.selectedValue(
                  newValue,
                );
                print(controller.selectedValue.value);
              },
              items: dropdownItems,
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
              // value: controller.selectedValue.value,
              onChanged: (String? newValue) {
                controller.kelasValue(
                  newValue,
                );
                print(controller.kelasValue.value);
              },
              items: kelasItems,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              hint: const Text(
                'Jurusan',
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // value: controller.selectedValue.value,
              onChanged: (String? newValue) {
                controller.jurusanValue(
                  newValue,
                );
                print(controller.jurusanValue.value);
              },
              items: jurusanItems,
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: controller.passC,
                obscureText: controller.isHidden.value,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value!.isEmpty ? 'invalid this required' : null,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: controller.confirmC,
                obscureText: controller.isHidden.value,
                keyboardType: TextInputType.text,
                validator: (value) => value != controller.passC.text
                    ? 'Password dont mact'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Password Confirm',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              )),
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  controller.register();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Obx(
                  () {
                    return controller.isLoading.value
                        ? const Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        : const Text(
                            'Registrasi',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            const textButtom(text: 'Login', Routess: Routes.LOGIN)
          ],
        ),
      ),
    );
  }
}
