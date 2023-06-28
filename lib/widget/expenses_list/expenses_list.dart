import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final Function(Expense expense) onSlideToDelete;
  final List<Expense> expenseDataList;
  const ExpensesList({
    super.key,
    required this.expenseDataList,
    required this.onSlideToDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseDataList.length,
      itemBuilder: ((context, index) => ExpenseItem(
            expense: expenseDataList[index],
            onSlideToDelete: onSlideToDelete,
          )),
    );
  }
}
