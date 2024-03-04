import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/models/GuruModel.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/guru_controller.dart';

class GuruView extends GetView<GuruController> {
  GuruView({Key? key}) : super(key: key);
  final pages = Get.find<PageIndexController>();
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
      body: FutureBuilder(
          future: controller.getDataGuru(),
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
                        textHome(label: guru.namaGuru, fontSize: 20)
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
                        label: guru.level,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      textHome(
                        label: guru.nip,
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: FutureBuilder(
                      future: controller.getDataBarcode(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const textHome(label: 'Masuk', fontSize: 14),
                                Text(
                                  snap.data.isEmpty
                                      ? '-'
                                      : DateFormat.jms().format(
                                          DateTime.parse(
                                            snap.data[0]['created_at'] ?? '-',
                                          ),
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
                                Text(snap.data.isEmpty
                                    ? '-'
                                    : snap.data[0]['mata_pelajaran']
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textHome(
                      label: 'This Week',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                    future: controller.getDataBarcode(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snap.hasData || snap.data.isEmpty) {
                        return const Center(
                          child: Text("Data Tidak Di temukan"),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snap.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = snap.data[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(20),
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const textHome(
                                          label: 'Masuk',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textHome(
                                          label: DateFormat.jms().format(
                                            DateTime.parse(
                                              data['created_at'] ?? 0,
                                            ),
                                          ),
                                          fontSize: 14,
                                        ),
                                        const SizedBox(height: 10),
                                        textHome(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          label: 'Pelajaran ' +
                                              data['mata_pelajaran']
                                                  ['mata_pelajaran'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: QrImageView(
                                        data: data['id'].toString(),
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    })
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
