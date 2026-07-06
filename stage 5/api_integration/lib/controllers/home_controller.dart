import 'package:get/get.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final recipeList = await _apiService.getRecipe();

      recipes.value = recipeList;

      if (recipes.isEmpty) {
        errorMessage.value = 'No recipes found';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void retryFetch() {
    fetchRecipes();
  }
}
