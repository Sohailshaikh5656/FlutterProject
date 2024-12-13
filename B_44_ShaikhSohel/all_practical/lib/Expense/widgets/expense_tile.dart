import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onRemove;

  const ExpenseTile({required this.expense, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(
            'Amount: \$${expense.amount.toStringAsFixed(2)} \nDate: ${expense.date.toString().split(' ')[0]}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
