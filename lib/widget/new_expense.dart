import 'package:flutter/material.dart';
import 'package:thirdapp_v5/model/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense(this._addExpense, {super.key});

  void Function(Expense expense) _addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var datePicker;
  Category _categorySelecter = Category.leisure;
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void visibleDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.day, now.month);

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      datePicker = pickedDate;
    });
  }

  void _submitExpenseData() {
    var enteredAmount = double.tryParse(_amountController.text);
    var amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        datePicker == null) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Invalid Expense'),
                content:
                    const Text('Make sure you enter the valid input fields'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ok'))
                ],
              );
            });
      });
    }
    widget._addExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount!,
          date: datePicker,
          category: _categorySelecter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSize + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                          maxLength: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration:
                              const InputDecoration(label: Text('Amount')),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('Title')),
                    maxLength: 50,
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _categorySelecter,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              value = _categorySelecter;
                            });
                          }),
                      const Spacer(),
                      Text(datePicker == null
                          ? 'No date Selected'
                          : formatter.format(datePicker)),
                      IconButton(
                          onPressed: visibleDatePicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration:
                              const InputDecoration(label: Text('Amount')),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Row(
                        children: [
                          Text(datePicker == null
                              ? 'No date Selected'
                              : formatter.format(datePicker)),
                          IconButton(
                              onPressed: visibleDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      )
                    ],
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Submit Expense'))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _categorySelecter,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              value = _categorySelecter;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Submit Expense'))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
