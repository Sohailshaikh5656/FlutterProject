import 'package:flutter/material.dart';
import 'custom_card.dart'; // Import your custom card

class ExpenseListPage1 extends StatelessWidget {
  final List<Map<String, dynamic>> expenses = [
    {'title': 'Groceries', 'amount': 50.25},
    {'title': 'Transport', 'amount': 15.75},
    {'title': 'Utilities', 'amount': 100.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return CustomCard(
            title: expenses[index]['title'],
            amount: expenses[index]['amount'],
            color: index.isEven ? Colors.blue : Colors.green, // Alternate colors
          );
        },
      ),
    );
  }
}
