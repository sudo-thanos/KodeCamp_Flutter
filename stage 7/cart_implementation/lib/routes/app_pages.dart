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
import '../views/profile_view.dart';
import '../views/edit_profile_view.dart';
import '../bindings/profile_binding.dart';
import '../views/recipe_detail_view.dart';
import '../bindings/recipe_detail_binding.dart';
import '../views/cart_view.dart';
import '../bindings/cart_binding.dart';
import '../views/checkout_view.dart';
import '../bindings/checkout_binding.dart';
import '../views/payment_view.dart';
import '../bindings/payment_binding.dart';
import '../views/success_view.dart';
import '../bindings/success_binding.dart';
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

    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileView()),

    GetPage(
      name: AppRoutes.recipeDetail,
      page: () => const RecipeDetailView(),
      binding: RecipeDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppRoutes.success,
      page: () => const SuccessView(),
      binding: SuccessBinding(),
    ),
  ];
}
