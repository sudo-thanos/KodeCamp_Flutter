import 'package:get/get.dart';
import '../models/recipe_model.dart';
import '../controllers/recipe_detail_controller.dart';

class RecipeDetailBinding extends Bindings {
  @override
  void dependencies() {
    final recipe = Get.arguments as Recipe;
    Get.put(RecipeDetailController(recipe));
  }
}
