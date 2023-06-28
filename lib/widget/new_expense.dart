import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/model/styles.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense) addexpense;
  const NewExpense({
    required this.addexpense,
    super.key,
  });

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseType? _selectedExpenseType;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constrain) {
      final width = constrain.maxWidth;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Expense'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: 'NT\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Expense'),
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<ExpenseType>(
                      value: _selectedExpenseType,
                      items: ExpenseType.values.map((item) {
                        return DropdownMenuItem<ExpenseType>(
                          value: item,
                          child: Row(
                            children: [
                              Icon(
                                typeIcons[item],
                                color: Styles.defaultGreenColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedExpenseType = value;
                        });
                      },
                    ),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select a date'
                                : formatter.format(_selectedDate!),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            iconSize: 35,
                            onPressed: () {
                              _presentDatePicker();
                            },
                            icon: const Icon(Icons.calendar_month_rounded),
                          )
                        ],
                      ),
                    )
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: 'NT\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select a date'
                                : formatter.format(_selectedDate!),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            iconSize: 35,
                            onPressed: () {
                              _presentDatePicker();
                            },
                            icon: const Icon(Icons.calendar_month_rounded),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              const SizedBox(
                height: 15,
              ),
              if (width >= 600)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseData();
                      },
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton<ExpenseType>(
                      value: _selectedExpenseType,
                      items: ExpenseType.values.map((item) {
                        return DropdownMenuItem<ExpenseType>(
                          value: item,
                          child: Row(
                            children: [
                              Icon(
                                typeIcons[item],
                                color: Styles.defaultGreenColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedExpenseType = value;
                        });
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text('Save Expense'),
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      );
    });
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = (enteredAmount == null || enteredAmount <= 0);
    if (_nameController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text('make suke all data are entered'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'exit',
                    style: TextStyle(
                      color: Styles.defaultGreenColor,
                    ),
                  ),
                )
              ],
            )),
      );
      return;
    }
    widget.addexpense(Expense(
      title: _nameController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      expenseType: _selectedExpenseType!,
    ));
    Navigator.pop(context);
  }
}
