import 'package:get/get.dart';
import '../models/recipe_model.dart';
import 'cart_controller.dart';

class RecipeDetailController extends GetxController {
  final Recipe recipe;
  RecipeDetailController(this.recipe);

  final CartController _cart = Get.find<CartController>();

  final RxInt quantity = 1.obs;

  void increment() => quantity.value++;

  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  void addToCart() {
    _cart.addToCart(recipe, quantity: quantity.value);
    Get.snackbar(
      'Added to cart',
      '${quantity.value} x ${recipe.name} added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
    quantity.value = 1;
  }
}
