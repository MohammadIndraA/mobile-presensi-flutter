import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_presence/app/modules/home/views/home_view.dart';
import 'package:smart_presence/app/pages/overlay.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:smart_presence/contans.dart';
import 'package:sp_util/sp_util.dart';

import '../modules/home/controllers/home_controller.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

bool isLoading = false;
final homme = Get.put(HomeController());
class _QrScannerState extends State<QrScanner> {
  bool isScanningComplete = false;
  // late String uid;
  void closeScreen() {
    isScanningComplete = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.off(HomeView()),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const textQr(
          color: Colors.black87,
          size: 18,
          spacing: 1,
          title: 'QR scanner',
          weight: FontWeight.bold,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textQr(
                    color: Colors.black87,
                    size: 18,
                    spacing: 1,
                    title: 'Place the Qr Code the area',
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  textQr(
                    color: Colors.black54,
                    size: 16,
                    spacing: 0,
                    title: 'Acanneing will be started automatical',
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: isLoading == true
                  ? const CircularProgressIndicator()
                  : Stack(
                      children: [
                        // MobileScanner(
                        //   onDetect: (capture) async {
                        //     if (!isScanningComplete) {
                        //       final List<Barcode> barcodes = capture.barcodes;
                        //       Set<String> uniqueUids =
                        //           {}; // Menggunakan Set untuk kode unik

                        //       for (final codes in barcodes) {
                        //         uniqueUids.add(codes.rawValue!);
                        //         debugPrint('Barcode found! ${codes.rawValue!}');
                        //       }

                        //       if (uniqueUids.isEmpty) {
                        //         return;
                        //       }

                        //       isLoading = true;

                        //       try {
                        //         List<Future> requests = [];

                        //         for (String uid in uniqueUids) {
                        //           requests.add(
                        //             http.post(
                        //               Uri.parse(
                        //                   "${URL}presensi/create/$uid/${SpUtil.getString('nis')}"),
                        //               headers: {
                        //                 'Accept': 'application/json',
                        //                 'Authorization':
                        //                     'Bearer ${SpUtil.getString('token')}',
                        //               },
                        //             ),
                        //           );
                        //         }

                        //         List responses = await Future.wait(requests);

                        //         for (var response in responses) {
                        //           var data = json.decode(response.body);
                        //           print(
                        //               'Ini STATUS NYA BROO ${response.statusCode}');
                        //           if (response.statusCode == 201) {
                        //             Get.snackbar('Success', data['message']);
                        //           } else {
                        //             Get.snackbar('Error', data['message']);
                        //           }
                        //         }
                        //       } catch (e) {
                        //         print(e.toString());
                        //       }

                        //       isLoading = false;
                        //       isScanningComplete = true;
                        //       Get.offAllNamed(Routes.HOME);
                        //     }
                        //   },
                        // ),

                        MobileScanner(
                          onDetect: (capture) async {
                            if (!isScanningComplete) {
                              late var uid;
                              final List<Barcode> barcodes = capture.barcodes;
                              for (final codes in barcodes) {
                                uid = codes.rawValue!;
                                debugPrint('Barcode found! ${codes.rawValue!}');
                              }
                              isLoading = true;
                              print(uid);
                              var respon = await http.post(
                                Uri.parse(
                                    "${URL}presensi/create/$uid/${SpUtil.getString('nis')}"),
                                headers: {
                                  'Accept': 'application/json',
                                  'Authorization':
                                      'Bearer ${SpUtil.getString('token')}',
                                },
                              );
                              var data = json.decode(respon.body);
                              if (respon.statusCode == 201) {
                                Get.snackbar('Success', data['message']);
                              } else {
                                print(data['message']);
                                Get.snackbar('Error', data['message']);
                              }
                              isScanningComplete = true;
                              Get.offAllNamed(Routes.HOME);
                            }
                          },
                        ),

                        const QRScannerOverlay(
                          overlayColour: Colors.white,
                        )
                      ],
                    ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const textQr(
                  color: Colors.black87,
                  size: 14,
                  spacing: 1,
                  title: 'Smart Precence',
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class textQr extends StatelessWidget {
  final String title;
  final Color color;
  final double size;
  final FontWeight weight;
  final double spacing;
  const textQr(
      {super.key,
      required this.title,
      required this.color,
      required this.size,
      required this.weight,
      required this.spacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: 1,
      ),
    );
  }
}
