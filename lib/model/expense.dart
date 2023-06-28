import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum ExpenseType {
  food,
  grocery,
  transport,
  clothing,
  healthcare,
  pet,
  social,
  leisure,
}

const typeIcons = {
  ExpenseType.food: Icons.local_dining_rounded,
  ExpenseType.grocery: Icons.shopping_cart_rounded,
  ExpenseType.transport: Icons.train_rounded,
  ExpenseType.clothing: Icons.boy_outlined,
  ExpenseType.healthcare: Icons.medical_services_rounded,
  ExpenseType.pet: Icons.pets_rounded,
  ExpenseType.social: Icons.group_rounded,
  ExpenseType.leisure: Icons.sports_bar_rounded,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType expenseType;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.expenseType,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final ExpenseType expenseType;
  final List<Expense> expenses;

  ExpenseBucket({
    required this.expenseType,
    required this.expenses,
  });

  ExpenseBucket.forExpenseType(List<Expense> allExpenses, this.expenseType)
      : expenses = allExpenses
            .where((expense) => expense.expenseType == expenseType)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
