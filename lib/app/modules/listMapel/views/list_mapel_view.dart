import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/models/MapelModel.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import '../controllers/list_mapel_controller.dart';

final pages = Get.find<PageIndexController>();
final cont = Get.put(ListMapelController());

class ListMapelView extends GetView<ListMapelController> {
  const ListMapelView({Key? key}) : super(key: key);
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
            future: controller.getData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snap.hasData) {
                return const Center(
                  child: Text('Tidak Ada Data Matapelajaran'),
                );
              }
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  final MapelModel mapel = snap.data![index];
                  return Card(
                    child: ListTile(
                      title: textHome(
                        label: 'Jam : ${mapel.jam}',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: textHome(
                        label: 'Mata Pelajaran : ${mapel.mataPelajaran}',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: textHome(
                        label: mapel.hari,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            }),
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

// GridView.count(
//         padding: const EdgeInsets.all(20),
//         crossAxisCount: 2,
//         mainAxisSpacing: 15,
//         crossAxisSpacing: 15,
//         childAspectRatio: 3 / 4,
//         children: kotak,
//       ),