import 'package:dio/dio.dart';
import '../models/recipe_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  final Dio _dio = Dio();

  Future<List<Recipe>> getRecipe() async {
    try {
      final response = await _dio.get('$baseUrl/recipes');

      if (response.statusCode == 200) {
        final List recipes = response.data['recipes'] ?? [];

        return recipes.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } on DioException catch (error) {
      throw Exception('Network error: ${error.message}');
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
