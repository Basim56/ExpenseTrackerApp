import 'package:flutter/material.dart';
import 'package:thirdapp_v5/main.dart';
import 'package:thirdapp_v5/widget/chart/chart.dart';
import 'package:thirdapp_v5/widget/expenses_list/expenses_list.dart';
import 'package:thirdapp_v5/model/expense.dart';
import 'package:thirdapp_v5/widget/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 12.0,
        date: DateTime.now(),
        category: Category.work)
  ];

  void submitExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    var expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Expense Removed',
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void openModalOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewExpense(submitExpense));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text('No expenses found. Start adding some'));

    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          deleteExpense: removeExpense, expenses: registeredExpenses);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: openModalOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: registeredExpenses),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
