import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // CartController is normally already put as a permanent singleton in
    // main(). This guards the Cart route in case it's ever the entry point.
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController(), permanent: true);
    }
  }
}
