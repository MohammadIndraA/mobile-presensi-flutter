import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/widget/textButtom.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_presence/widget/textForm.dart';

import '../controllers/login_controller.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final controller = Get.put(LoginController());

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Lottie.asset('assets/lottie/register.json'),
            ),
            Text(
              'Login',
              style: GoogleFonts.urbanist(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            textForm(
                controller: controller.nisp,
                label: 'Masukan Nis/Nip Anda',
                obscureText: false,
                keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                controller: controller.passC,
                obscureText: controller.isHidden.value,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value!.isEmpty ? 'Password harus di isi' : null,
                decoration: InputDecoration(
                  label: Text(
                    'Masukan Paasword Anda',
                    style: GoogleFonts.urbanist(
                      color: const Color(0xff8390a1),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Text(
            //       'Lupa password',
            //       style: TextStyle(fontSize: 12),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  controller.login();
                }
              },
              style: ElevatedButton.styleFrom(
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
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const textButtom(text: 'Registrasi', Routess: Routes.REGISTER)
          ],
        ),
      ),
    );
  }
}
