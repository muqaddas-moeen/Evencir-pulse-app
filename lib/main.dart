import 'package:evencir_pulse_app/bindings/app_bindings.dart';
import 'package:evencir_pulse_app/features/auth/controllers/storage_controller.dart';
import 'package:evencir_pulse_app/firebase_options.dart';
import 'package:evencir_pulse_app/models/user_model.dart';
import 'package:evencir_pulse_app/services/firestore/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/routes/app_pages.dart';
import 'core/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppBindings().dependencies();

  // Check login status
  String initialRoute = Routes.LOGIN;
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    try {
      final userService = UserService();
      UserModel? userData = await userService.fetchUserData(currentUser.uid);
      if (userData != null) {
        Get.find<StorageController>().setUser(userData, userData.id!);
        initialRoute = Routes.BOTTOM_NAV_BAR;
      } else {
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during auto-login: $e");
      }
      await FirebaseAuth.instance.signOut();
    }
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Evencir Pulse',
        theme: AppTheme.darkTheme,
        initialRoute: initialRoute,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
