import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/splash_view.dart';
import '../views/onboarding_view.dart';
// import '../views/auth_view.dart';
import '../views/register_view.dart';
// import '../views/home_view.dart';
import '../bindings/splash_binding.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/register_binding.dart';
import '../bindings/home_binding.dart';
import '../screens/main_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: AppRoutes.main,
      page: () {
        final args = Get.arguments ?? {};
        return MainScreen(email: args['email'] ?? '', name: args['name']);
      },
      binding: HomeBinding(),
    ),
  ];
}
