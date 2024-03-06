import 'package:flutter/material.dart';
import 'package:thirdapp_v5/model/expense.dart';

class ExpensesItem extends StatelessWidget {
  ExpensesItem(this.expense, {super.key});
  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Icon(categoryIcon[expense.category]),
                const SizedBox(
                  width: 12,
                ),
                Text(expense.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
