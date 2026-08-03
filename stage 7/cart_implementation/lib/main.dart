import 'package:flutter/material.dart';
// import 'splash_screen.dart';
import 'package:get/get.dart';
// import 'views/splash_view.dart';
import 'routes/app_pages.dart';
// import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'controllers/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  // CartController is put once here (permanent) so the same cart instance
  // is shared by the Detail, Cart, Checkout, Payment and Success screens.
  Get.put(CartController(), permanent: true);
  runApp(const MyApp());
}

// AApp entry point
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Contains the main components o the app, like the title, the font, defines the splash screen as the entrypoint
  // Also disables the debug banner
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book\'n Eat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      //   home: const SplashView(),
    );
  }
}
