import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';

import '../controllers/absen_controller.dart';

final pages = Get.find<PageIndexController>();
final cont = Get.put(AbsenController());
final List code = Get.arguments();
int? kelas;
Map<String, dynamic>? mapel;

class AbsenView extends GetView<AbsenController> {
  const AbsenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getKelas();
    controller.getMapel();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder(
                  future: controller.getKelas(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snap.hasData) {
                      return const Center(
                        child: Text('Tidak Ada Data kelas'),
                      );
                    }
                    List data = snap.data;
                    return DropdownButton(
                      hint: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Pilih Kelas'),
                      ),
                      items: data.map<DropdownMenuItem<int>>((item) {
                        return DropdownMenuItem<int>(
                          value: item['id'],
                          child: Text(item['jurusan']),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (value) {
                        if (value != null) {
                          controller.values.value = value as int;
                          print(controller.values.value);
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder(
                    future: controller.getMapel(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snap.hasData) {
                        return const Center(
                          child: Text('Tidak Ada Data Mata Pelajaran'),
                        );
                      }
                      List data = snap.data;
                      return DropdownButton(
                        hint: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Pilih Mata Pelajaran'),
                        ),
                        items: data.map<DropdownMenuItem<int>>((item) {
                          return DropdownMenuItem<int>(
                            value: item['id'],
                            child: Text(item['mata_pelajaran']),
                          );
                        }).toList(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        underline: Container(),
                        isExpanded: true,
                        onChanged: (value) {
                          if (value != null) {
                            controller.values.value = value as int;
                            print(controller.values.value);
                          }
                        },
                      );
                    }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: QrImageView(
                      data: '2023-09-08 13:00 00-0987',
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 73, 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.postBarcode();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      () {
                        return controller.isLoading.value
                            ? const Text(
                                'Loading...',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Buat Qr Code',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => Get.to(() => const QrScanner()),
              //   child: const Text('Sacnner'),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => codes(),
              //   child: const Text('data'),
              // ),
              const SizedBox(height: 20)
            ],
          )
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.filter_frames_outlined, title: 'Mapel'),
          TabItem(icon: Icons.qr_code_2_outlined, title: 'Absen'),
          TabItem(icon: Icons.people, title: 'Profile')
        ],
        initialActiveIndex: pages.pageIndex.value,
        onTap: (int i) => pages.changePage(i),
      ),
    );
  }
}
