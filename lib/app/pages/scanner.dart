import 'dart:convert';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String barcode = 'Ketuk untuk memindai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Scanner'),
        actions: [
          IconButton(
            onPressed: () => Get.offNamed(Routes.HOME),
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
      body: AiBarcodeScanner(
        validator: (value) {
          return value.startsWith('https://');
        },
        canPop: false,
        onScan: (String value) {
          print(value);
        },
        onDetect: (p0) async {
          setState(() {
            barcode = p0.raw[0]['rawValue'];
          });
          if (SpUtil.getString('kode') == barcode) {
            Get.snackbar('Terimaksih', 'Anda sudah absen mata pelajaran ini');
            Get.offNamed(Routes.HOME);
          } else if (SpUtil.getString('kode') == '0') {
            // Memeriksa apakah 'kode' adalah string '0'
            Get.snackbar('Error', 'Maaf, QR code Anda Salah');
            Get.offNamed(Routes.HOME);
          } else {
            try {
              var response = await http.post(
                Uri.parse(
                    "${URL}presensi/create/$barcode/${SpUtil.getString('nis')}"),
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${SpUtil.getString('token')}',
                },
              );
              var data = json.decode(response.body);
              print(data);
              String barcodeId = data['presensi']['barcode_id'].toString();
              SpUtil.putString('kode', barcodeId); // Simpan sebagai string
              if (response.statusCode == 200) {
                Get.snackbar('Berhasil', 'Terimaksih sudah Absensi');
              } else {
                Get.snackbar('Kesalahan', data['message']);
              }
            } catch (e) {
              print('Ini Responnya ${e.toString()}');
              Get.snackbar('Kesalahan', 'Tidak dapat melakukan absensi');
            }

            Get.offNamed(Routes.HOME);
          }
        },
        onDispose: () {
          debugPrint("Pemindai kode batang dinonaktifkan!");
        },
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
      ),
    );
  }
}
