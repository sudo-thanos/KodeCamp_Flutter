import 'dart:math';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';

class PaymentController extends GetxController {
  final CartController _cart = Get.find<CartController>();

  late final Map<String, dynamic> deliveryDetails =
      (Get.arguments as Map<String, dynamic>?) ?? {};

  final RxBool isProcessing = false.obs;
  final RxString errorMessage = ''.obs;

  double get total => _cart.totalPrice;

  int get itemCount => _cart.totalItemCount;

  Future<void> processPayment() async {
    isProcessing.value = true;
    errorMessage.value = '';

    // Snapshot the cart before it gets cleared, so the Success screen has
    // something to recap even after CartController.clear() runs.
    final orderItems = _cart.items
        .map(
          (item) => {
            'name': item.recipe.name,
            'quantity': item.quantity.value,
            'subtotal': item.subtotal,
          },
        )
        .toList();
    final orderTotal = _cart.totalPrice;

    final random = Random();
    await Future.delayed(Duration(seconds: 2 + random.nextInt(2)));

    // Mock gateway: succeeds most of the time, occasionally simulates failure.
    final didSucceed = random.nextDouble() < 0.85;

    if (didSucceed) {
      final orderId =
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
      _cart.clear();
      isProcessing.value = false;
      Get.offNamed(
        AppRoutes.success,
        arguments: {
          'orderId': orderId,
          'items': orderItems,
          'total': orderTotal,
          'deliveryDetails': deliveryDetails,
        },
      );
    } else {
      errorMessage.value = 'Payment failed. Please try again.';
      isProcessing.value = false;
    }
  }

  void retry() => processPayment();
}
