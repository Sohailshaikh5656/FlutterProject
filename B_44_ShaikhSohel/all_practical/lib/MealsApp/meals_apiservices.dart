import 'package:all_practical/MealsApp/meals_model.dart';
import 'package:dio/dio.dart';

class MealsApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  // Fetch meals by category
  Future<List<Meal>> fetchMealsByCategory(String category) async {
    try {
      final response = await _dio.get('${baseUrl}filter.php?c=$category');
      print('API Response: ${response.data}');
      if (response.data['meals'] != null) {
        List<dynamic> mealsData = response.data['meals'];
        return mealsData.map((meal) => Meal.fromJson(meal)).toList();
      }
    } catch (e) {
      print("Error fetching meals by category: $e");
    }
    return [];
  }

  // Fetch all meals
  Future<List<Meal>> fetchMeals() async {
    try {
      final response = await _dio.get('${baseUrl}search.php?s=');
      if (response.data['meals'] != null) {
        List<dynamic> mealsData = response.data['meals'];
        return mealsData.map((meal) => Meal.fromJson(meal)).toList();
      }
    } catch (e) {
      print("Error fetching meals: $e");
    }
    return [];
  }
}
