import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/models/KelasModel.dart';
import 'package:smart_presence/app/models/MapelModel.dart';
import 'package:smart_presence/app/modules/absen/controllers/absen_controller.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Barcode extends StatefulWidget {
  const Barcode({super.key});

  @override
  State<Barcode> createState() => _BarcodeState();
}

bool isLoading = false;
int kelas = 1;

int jurusan = 1;
Map<String, dynamic> allData = {};

class _BarcodeState extends State<Barcode> {
  final pages = Get.find<PageIndexController>();
  final controller = Get.put(AbsenController());

  @override
  Widget build(BuildContext context) {
    const Interval(1, 10);
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
                child: DropdownSearch<KelasModel>(
                  popupProps: const PopupProps.menu(),
                  asyncItems: (text) async {
                    var response = await http.get(
                      Uri.parse("${URL}kelas"),
                      headers: {
                        'Accept': 'application/json',
                        'Authorization': 'Bearer ${SpUtil.getString('token')}',
                      },
                    );

                    List<KelasModel> allNameKelas = [];
                    if (response.statusCode == 200) {
                      List kelases = (json.decode(response.body)
                          as Map<String, dynamic>)['kelas'];
                      kelases.forEach((element) {
                        allNameKelas.add(
                          (KelasModel(
                            id: element['id'],
                            kodeKelas: element['kode_kelas'],
                            namaKelas: element['nama_kelas'],
                            jurusan: element['jurusan'],
                            createdAt: DateTime.parse(element['created_at']),
                            updatedAt: DateTime.parse(element['updated_at']),
                          )),
                        );
                        print('kelas ${element}'); // Perubahan di sini
                      });
                    }
                    return allNameKelas; // Perubahan di sini, mengembalikan List<String>
                  },
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih",
                      hintText: "Pilih kelas",
                    ),
                  ),
                  itemAsString: (KelasModel item) => item.jurusan,
                  onChanged: (value) {
                    print(
                        'Ini kelass nya ${value?.id}'); // Anda mungkin ingin mengganti kelas dengan value
                    if (value != null) {
                      kelas = value.id;
                    }
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
                child: DropdownSearch<MapelModel>(
                  popupProps: const PopupProps.menu(),
                  asyncItems: (text) async {
                    var response = await http.get(
                      Uri.parse("${URL}mapel/showDay"),
                      headers: {
                        'Accept': 'application/json',
                        'Authorization': 'Bearer ${SpUtil.getString('token')}',
                      },
                    );

                    List<MapelModel> allNameKelas = [];
                    if (response.statusCode == 200) {
                      List kelases = (json.decode(response.body)
                          as Map<String, dynamic>)['mata_pelajaran'];
                      kelases.forEach((element) {
                        allNameKelas.add((MapelModel(
                          id: element['id'] ?? 0,
                          kodePelajaran: element['kode_pelajaran'],
                          mataPelajaran: element['mata_pelajaran'],
                          hari: element['hari'],
                          jam: element['jam'],
                          kelasId: element['kelas_id'],
                          guruId: element['guru_id'],
                          createdAt: DateTime.parse(element['created_at']),
                          updatedAt: DateTime.parse(element['updated_at']),
                        )));
                        print('kelas ${element['id']}'); // Perubahan di sini
                      });
                    }
                    return allNameKelas; // Perubahan di sini, mengembalikan List<String>
                  },
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih",
                      hintText: "Pilih mata pelajaran",
                    ),
                  ),
                  itemAsString: (MapelModel item) => item.mataPelajaran,
                  onChanged: (value) {
                    print(
                        'Ini kelass nya ${value?.id}'); // Anda mungkin ingin mengganti kelas dengan value
                    if (value != null) {
                      jurusan = value.id;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (allData.isNotEmpty)
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: QrImageView(
                        data: allData['barcode']['id'].toString(),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  if (allData.isEmpty) const Text('Belum ada Code qr Code'),
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
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      var respon = await http.post(
                          Uri.parse(
                              "${URL}barcode/create/${SpUtil.getString('nis')}"),
                          headers: {
                            'Accept': 'application/json',
                            'Authorization':
                                'Bearer ${SpUtil.getString('token')}',
                          },
                          body: {
                            'mata_pelajaran_id': jurusan.toString(),
                            'kelas_id': kelas.toString(),
                          });
                      var data = json.decode(respon.body);
                      setState(() {
                        allData = data;
                      });
                      print('barcode $allData');
                      print(respon.statusCode);
                      if (respon.statusCode == 200) {
                        Get.snackbar(
                            'Success', 'Terimaksih telah membuat bercode');
                      } else {
                        print(data['message']);
                        Get.snackbar('Error', data['message']);
                      }
                    } catch (e) {
                      print(e.toString());
                      Get.snackbar('Error', 'Gagal membuat barcode');
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: isLoading == true
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
