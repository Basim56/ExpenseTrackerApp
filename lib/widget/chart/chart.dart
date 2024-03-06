import 'package:flutter/material.dart';
import 'package:thirdapp_v5/model/expense.dart';
import 'package:thirdapp_v5/widget/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  Chart({super.key, required this.expenses});

  List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.lunch),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.leisure),
    ];
  }

  double get maxTotalExpense {
    double maxExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxExpense) {
        maxExpense = bucket.totalExpenses;
      }
    }
    return maxExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(colors: [
          ThemeData().colorScheme.primary.withOpacity(0.3),
          ThemeData().colorScheme.primary.withOpacity(0.0)
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            children: [
              for (final bucket in buckets)
                ChartBar(
                    fill: maxTotalExpense == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense)
            ],
          )),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: buckets
                .map((bucket) => Expanded(
                        child: Icon(
                      categoryIcon[bucket.category],
                      color: isDarkMode
                          ? ThemeData().colorScheme.secondary
                          : ThemeData().colorScheme.primary.withOpacity(0.7),
                    )))
                .toList(),
          )
        ],
      ),
    );
  }
}
