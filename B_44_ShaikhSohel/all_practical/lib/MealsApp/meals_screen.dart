import 'package:all_practical/MealsApp/meal_Serch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'meals_controller.dart';


class MealsScreen extends StatelessWidget {
  final MealsController mealsController = Get.put(MealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MealSearchDelegate());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),  // Add the category filter here
          Expanded(
            child: Obx(() {
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
            }),
          ),
        ],
      ),
    );
  }

  // Category filter to select Veg, Non-Veg, or All
  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _filterButton('All'),
          _filterButton('Vegetarian'),
          _filterButton('Non-Vegetarian'),
        ],
      ),
    );
  }

  // Filter button that updates the selected category
  Widget _filterButton(String category) {
    return ElevatedButton(
      onPressed: () {
        mealsController.selectedCategory.value = category;
        mealsController.fetchMeals(); // Fetch meals based on selected category
      },
      child: Text(category),
    );
  }
}

