import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'meals_controller.dart';


class MealSearchDelegate extends SearchDelegate {
  final MealsController mealsController = Get.find();  // Use GetX to access the controller

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';  // Clear the search query
          mealsController.searchMeals('');  // Reset the search to show all meals
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform search when the user submits the query
    mealsController.searchMeals(query);
    return Obx(() {
      // Show filtered results based on search
      return ListView.builder(
        itemCount: mealsController.filteredMeals.length,
        itemBuilder: (context, index) {
          final meal = mealsController.filteredMeals[index];
          return ListTile(
            leading: Image.network(meal.imageUrl),
            title: Text(meal.name),
            subtitle: Text(meal.category),
            trailing: IconButton(
              icon: Icon(
                meal.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: meal.isFavorite ? Colors.red : null,
              ),
              onPressed: () => mealsController.addToFavorites(meal),
            ),
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    mealsController.searchMeals(query);
    return Obx(() {
      // Show filtered suggestions based on search
      return ListView.builder(
        itemCount: mealsController.filteredMeals.length,
        itemBuilder: (context, index) {
          final meal = mealsController.filteredMeals[index];
          return ListTile(
            leading: Image.network(meal.imageUrl),
            title: Text(meal.name),
            subtitle: Text(meal.category),
            trailing: IconButton(
              icon: Icon(
                meal.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: meal.isFavorite ? Colors.red : null,
              ),
              onPressed: () => mealsController.addToFavorites(meal),
            ),
          );
        },
      );
    });
  }
}
