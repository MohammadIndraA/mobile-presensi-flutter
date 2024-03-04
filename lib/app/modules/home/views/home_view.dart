import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/models/UserModel.dart';
import 'package:smart_presence/app/modules/login/controllers/login_controller.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final pages = Get.find<PageIndexController>();
  final cont = Get.put(LoginController());
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    print(SpUtil.getString('jenisKelamin'));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' SMART PRESENCE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getData(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snap.hasData) {
              return const Center(
                child: Text('Tidak Ada Data yang ini'),
              );
            }
            UserModel user = snap.data;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 75,
                        width: 75,
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
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const textHome(
                          fontSize: 20,
                          label: 'Welcome',
                          fontWeight: FontWeight.bold,
                        ),
                        textHome(label: user.namaLengkap, fontSize: 20)
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textHome(
                        label: user.level,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      textHome(
                        label: user.nis,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      const textHome(
                        label: 'SMK Al Manshuriah ',
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: FutureBuilder(
                      future: controller.getDataAbssen(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var absenn = snap.data['presence'];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const textHome(label: 'Masuk', fontSize: 14),
                                Text(
                                  absenn.isEmpty
                                      ? '-'
                                      : DateFormat.Hms().format(
                                          DateTime.parse(
                                            absenn[0]['created_at'] ?? '-',
                                          ).toLocal(),
                                        ),
                                ),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.black54,
                            ),
                            Column(
                              children: [
                                const textHome(
                                    label: 'Pelajaran', fontSize: 14),
                                Text(absenn.isEmpty
                                    ? '-'
                                    : absenn[0]['mata_pelajaran']
                                            ['mata_pelajaran'] ??
                                        '-'),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                const SizedBox(height: 18),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const textHome(
                      label: 'This Week',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL_ABSEN);
                      },
                      child: const textHome(
                        label: 'See more',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: controller.getDataAbssen(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snap.hasData || snap.data['presence'].isEmpty) {
                      return const Center(
                        child: Text("Data Tidak Di temukan"),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.data['presence'].length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = snap.data['presence'][index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const textHome(
                                    label: 'Masuk',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textHome(
                                    label: DateFormat.yMMMEd().format(
                                      DateTime.parse(data['created_at'] ?? '-')
                                          .toLocal(),
                                    ),
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              textHome(
                                label: DateFormat.Hms().format(
                                  DateTime.parse(
                                    data['created_at'] ?? '-',
                                  ).toLocal(),
                                ),
                                fontSize: 14,
                              ),
                              const SizedBox(height: 10),
                              const textHome(
                                label: 'Pelajaran',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  textHome(
                                    label: data['mata_pelajaran']
                                            ['mata_pelajaran'] ??
                                        '-',
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            );
          }),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
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

class textHome extends StatelessWidget {
  const textHome({
    super.key,
    required this.label,
    this.fontWeight,
    required this.fontSize,
  });

  final String label;
  final fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
