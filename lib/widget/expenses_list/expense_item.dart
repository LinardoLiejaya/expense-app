import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/model/styles.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Function(Expense) onSlideToDelete;
  final Expense expense;
  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onSlideToDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: Theme.of(context).cardTheme.margin,
        color: Theme.of(context).colorScheme.error.withOpacity(0.8),
        child: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        onSlideToDelete(expense);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'NT\$ ${expense.amount}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        typeIcons[expense.expenseType],
                        color: Styles.defaultGreenColor,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        expense.formattedDate,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
