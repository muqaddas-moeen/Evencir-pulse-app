// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../features/auth/bindings/auth_binding.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/register_view.dart';
import '../features/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import '../features/bottom_nav_bar/bindings/bottom_nav_bar_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.STARTER;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: Routes.STARTER,
      page: () => const LoginView(), // Redirect starter to login for now
      binding: AuthBinding(),
    ),
  ];
}
