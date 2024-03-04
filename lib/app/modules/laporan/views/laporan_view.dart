import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../home/views/home_view.dart';
import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaporanView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
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
            itemBuilder: (context, index) {
              var data = snap.data['presence'][index];
              print(snap.data['presence'].length);
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              label: data['mata_pelajaran']['mata_pelajaran'] ??
                                  '-',
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
