import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/expense_controller.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final expenseController = Provider.of<ExpenseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: expenseController.expenses.length,
              itemBuilder: (context, index) {
                final expense = expenseController.expenses[index];
                return ExpenseTile(
                  expense: expense,
                  onRemove: () => expenseController.removeExpense(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Show dialog to add new expense
  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Expense'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Expense Title'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == null
                        ? 'Pick a date'
                        : 'Selected: ${_selectedDate!.toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _titleController.clear();
                _amountController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = _titleController.text;
                final amount = double.tryParse(_amountController.text);
                if (title.isNotEmpty && amount != null && _selectedDate != null) {
                  final expense = Expense(
                    title: title,
                    amount: amount,
                    date: _selectedDate!,
                  );
                  Provider.of<ExpenseController>(context, listen: false)
                      .addExpense(expense);
                  _titleController.clear();
                  _amountController.clear();
                  _selectedDate = null; // Reset the date after adding
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
