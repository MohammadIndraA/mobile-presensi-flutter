import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:smart_presence/app/modules/login/controllers/login_controller.dart';
import 'package:smart_presence/app/pages/updatePasswordSiswa.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/profile_controller.dart';

final pages = Get.find<PageIndexController>();
final cont = Get.put(LoginController());

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' SMART PRESENCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.grey[200],
                  child: Center(
                    child: (SpUtil.getString('jenisKelamin')) == "P"
                        ? Image.asset(
                            'assets/icon/wt.jpg',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/icon/lk.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (SpUtil.getString('level') == "Siswa")
                textHome(
                    label: (SpUtil.getString('nama') ?? '-'), fontSize: 20),
              textHome(
                  label: (SpUtil.getString('nama_guru') ?? '-'), fontSize: 20),
              textHome(label: (SpUtil.getString('level') ?? '-'), fontSize: 16),
            ],
          ),
          const SizedBox(height: 20),
          itemProfile(
            title: 'Update Profile',
            icons: Icons.person_2_outlined,
            Routess: (SpUtil.getString('level') == "Siswa")
                ? Routes.UPDATE_PROFILE
                : Routes.PROFILE_GURU,
          ),
          const SizedBox(height: 11),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: () {
                Get.to(() => const UpdatePasswordSiswa());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15,
              ),
              leading: const Icon(
                Icons.vpn_key,
              ),
              title: const Text('Update Password'),
            ),
          ),
          const SizedBox(height: 11),
          if (SpUtil.getString('level') == "Siswa")
            const itemProfile(
              title: 'Laporan Presensi',
              icons: Icons.file_copy_outlined,
              Routess: Routes.LAPORAN,
            ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: () {
                Get.defaultDialog(
                  backgroundColor: Colors.white,
                  title: 'Konfirmasi',
                  middleText: 'Yakin ingin keluar?',
                  cancel: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () async {
                      cont.logout();
                    },
                    child: Obx(
                      () {
                        return cont.isLoading.value
                            ? Text('Keluar...')
                            : Text('Keluar');
                      },
                    ),
                  ),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15,
              ),
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        // style: TabStyle.fixedCircle,
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.filter_frames_outlined, title: 'Mapel'),
          TabItem(icon: Icons.qr_code_2_outlined, title: 'Absen'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pages.pageIndex.value,
        onTap: (int i) => pages.changePage(i),
      ),
    );
  }
}

class itemProfile extends StatelessWidget {
  const itemProfile({
    super.key,
    required this.title,
    this.Routess,
    required this.icons,
  });

  final String title;
  final Routess;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed(Routess);
        },
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 15,
        ),
        leading: Icon(icons),
        title: Text(title),
      ),
    );
  }
}
