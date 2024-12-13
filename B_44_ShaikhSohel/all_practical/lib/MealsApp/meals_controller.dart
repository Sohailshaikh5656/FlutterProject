import 'package:all_practical/MealsApp/meals_apiservices.dart';
import 'package:all_practical/MealsApp/meals_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MealsController extends GetxController {
  var meals = <Meal>[].obs;
  var favoriteMeals = <Meal>[].obs;
  var searchText = ''.obs;
  var selectedCategory = 'All'.obs; // Default category is "All"

  final MealsApiService apiService = MealsApiService();

  @override
  void onInit() {
    super.onInit();
    fetchMeals(); // Initial fetch with 'All' category
  }

  // Function to fetch meals based on selected category
  void fetchMeals() async {
    if (selectedCategory.value == 'All') {
      meals.value = await apiService.fetchMeals(); // Fetch all meals if "All" is selected
    } else {
      meals.value = await apiService.fetchMealsByCategory(selectedCategory.value); // Fetch based on category
    }
  }

  // Add or remove meals from favorites
  void addToFavorites(Meal meal) {
    meal.isFavorite = !meal.isFavorite;
    if (meal.isFavorite) {
      favoriteMeals.add(meal);
    } else {
      favoriteMeals.removeWhere((m) => m.id == meal.id);
    }
  }

  // Search functionality
  void searchMeals(String query) {
    searchText.value = query;
  }

  // Filter meals based on search query
  List<Meal> get filteredMeals {
    if (searchText.value.isEmpty) {
      return meals;
    } else {
      return meals.where((meal) => meal.name.toLowerCase().contains(searchText.value.toLowerCase())).toList();
    }
  }
}
