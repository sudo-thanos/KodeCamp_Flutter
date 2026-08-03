import 'package:get/get.dart';
import '../models/cart_item.dart';
import '../models/recipe_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  bool get isEmpty => items.isEmpty;

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity.value);

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.subtotal);

  int _indexOf(int recipeId) =>
      items.indexWhere((item) => item.recipe.id == recipeId);

  void addToCart(Recipe recipe, {int quantity = 1}) {
    final index = _indexOf(recipe.id);
    if (index == -1) {
      items.add(CartItem(recipe: recipe, quantity: quantity));
    } else {
      items[index].quantity.value += quantity;
    }
  }

  void removeFromCart(int recipeId) {
    items.removeWhere((item) => item.recipe.id == recipeId);
  }

  void incrementQuantity(int recipeId) {
    final index = _indexOf(recipeId);
    if (index != -1) items[index].quantity.value++;
  }

  // Quantity floors at 1 - removal is a distinct, explicit action
  // (swipe-to-remove / remove icon), not an implicit side effect of "-".
  void decrementQuantity(int recipeId) {
    final index = _indexOf(recipeId);
    if (index == -1) return;
    if (items[index].quantity.value > 1) {
      items[index].quantity.value--;
    }
  }

  void clear() {
    items.clear();
  }
}
