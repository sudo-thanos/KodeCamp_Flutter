import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';

class SuccessController extends GetxController {
  late final Map<String, dynamic> orderData =
      (Get.arguments as Map<String, dynamic>?) ?? {};

  String get orderId => orderData['orderId'] ?? '';

  List<Map<String, dynamic>> get items =>
      (orderData['items'] as List?)?.cast<Map<String, dynamic>>() ?? [];

  double get total => (orderData['total'] as num?)?.toDouble() ?? 0;

  Map<String, dynamic> get deliveryDetails =>
      (orderData['deliveryDetails'] as Map?)?.cast<String, dynamic>() ?? {};

  void backToHome() {
    // Cart is already cleared right after a successful payment - clearing
    // again here is just a defensive no-op guarantee per the spec.
    Get.find<CartController>().clear();
    Get.offAllNamed(AppRoutes.main);
  }
}
