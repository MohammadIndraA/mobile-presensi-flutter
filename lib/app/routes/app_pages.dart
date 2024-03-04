import 'package:get/get.dart';

import '../modules/Guru/bindings/guru_binding.dart';
import '../modules/Guru/views/guru_view.dart';
import '../modules/absen/bindings/absen_binding.dart';
import '../modules/absen/views/absen_view.dart';
import '../modules/detail_absen/bindings/detail_absen_binding.dart';
import '../modules/detail_absen/views/detail_absen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/listMapel/bindings/list_mapel_binding.dart';
import '../modules/listMapel/views/list_mapel_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profileGuru/bindings/profile_guru_binding.dart';
import '../modules/profileGuru/views/profile_guru_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ABSEN,
        page: () => AbsenView(),
        binding: AbsenBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LIST_MAPEL,
        page: () => const ListMapelView(),
        binding: ListMapelBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.DETAIL_ABSEN,
      page: () => const DetailAbsenView(),
      binding: DetailAbsenBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.GURU,
      page: () => GuruView(),
      binding: GuruBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_GURU,
      page: () => ProfileGuruView(),
      binding: ProfileGuruBinding(),
    ),
  ];
}
