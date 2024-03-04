import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_presence/app/controllers/page_index_controller.dart';
import 'package:smart_presence/app/modules/login/controllers/login_controller.dart';
import 'package:smart_presence/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  Get.put(PageIndexController(), permanent: true);
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

final cont = Get.put(LoginController());

@override
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_element

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Presence',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 28, 73, 110),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.urbanistTextTheme(),
      ),
      // ignore: unnecessary_null_comparison
      initialRoute: (SpUtil.getString('token')!.isEmpty
          ? Routes.LOGIN
          : (SpUtil.getString('level') == "Guru" ? Routes.GURU : Routes.HOME)),
      getPages: AppPages.routes,
    );
  }
}
