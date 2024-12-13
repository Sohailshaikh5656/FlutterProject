
import 'package:all_practical/MealsApp/meals_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BMI/bmi_calculator.dart';
import 'Calculator/calculator.dart';
import 'Expense/controllers/expense_controller.dart';
import 'Expense/pages/expense_list_pages.dart';
// Assuming CalculatorScreen is defined in this file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseController(),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MealsScreen(),
      ),
    );
  }
}
