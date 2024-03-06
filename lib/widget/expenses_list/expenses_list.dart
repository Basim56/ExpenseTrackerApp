import 'package:flutter/material.dart';
import 'package:thirdapp_v5/model/expense.dart';
import 'package:thirdapp_v5/widget/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {required this.deleteExpense, required this.expenses, super.key});

  void Function(Expense expense) deleteExpense;

  List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction) => deleteExpense(expenses[index]),
              child: ExpensesItem(expenses[index]));
        });
  }
}
