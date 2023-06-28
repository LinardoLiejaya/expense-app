import 'package:expenses_app/model/styles.dart';
import 'package:expenses_app/widget/chart/chart.dart';
import 'package:expenses_app/widget/expenses_list/expenses_list.dart';
import 'package:expenses_app/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  int? index;
  final List<Expense> _registeredExpanses = [
    Expense(
      title: 'Huoguo',
      amount: 170,
      date: DateTime.now(),
      expenseType: ExpenseType.food,
    ),
    Expense(
      title: 'Cinema: Guardian of the Galaxy 3',
      amount: 270,
      date: DateTime.now(),
      expenseType: ExpenseType.leisure,
    ),
    Expense(
      title: 'Parking',
      amount: 30,
      date: DateTime.now(),
      expenseType: ExpenseType.transport,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Styles.defaultGreenColor,
        title: const Text('Expenses App'),
        actions: [
          IconButton(
            onPressed: () {
              _addExpenseData();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 500
          ? Column(
              children: [
                Chart(expenses: _registeredExpanses),
                const SizedBox(height: 20),
                Expanded(
                  child: _registeredExpanses.isEmpty
                      ? const Center(
                          child: Text(
                            'No expenses found. Start adding some!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ExpensesList(
                          expenseDataList: _registeredExpanses,
                          onSlideToDelete: _removeExpense,
                        ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpanses),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _registeredExpanses.isEmpty
                      ? const Center(
                          child: Text(
                            'No expenses found. Start adding some!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ExpensesList(
                          expenseDataList: _registeredExpanses,
                          onSlideToDelete: _removeExpense,
                        ),
                ),
              ],
            ),
    );
  }

  void _addExpenseData() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addexpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpanses.add(expense);
    });
    customSnackbar('New expense added', false, expense);
  }

  void _removeExpense(Expense expense) {
    setState(() {
      index = _registeredExpanses.indexOf(expense);
      _registeredExpanses.remove(expense);
    });
    customSnackbar('Expense deleted', true, expense);
  }

  void _undoDelete(Expense expense) {
    setState(() {
      _registeredExpanses.insert(index!, expense);
    });
  }

  void customSnackbar(
      String snackbarContent, bool isNeedUndo, Expense expense) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        snackbarContent,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: Styles.defaultLightGreenColor,
      action: isNeedUndo
          ? SnackBarAction(
              label: 'Undo',
              onPressed: () {
                _undoDelete(expense);
              },
            )
          : null,
    ));
  }
}
