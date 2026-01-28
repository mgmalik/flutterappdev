import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';

class ExpnseListDate extends StatelessWidget {
  const ExpnseListDate({
    super.key,
    required this.expenses,
    required this.onDelete,
  });
  final List<Expense> expenses;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final entry = expenses[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          elevation: 8.0,
          shadowColor: Colors.blueGrey,
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(
              '${entry.amount} - ${entry.payee}',
              style: TextStyle(
                color: Constants.appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('${entry.date} - Category: ${entry.categoryId}'),
            // subtitle: Text('${entry.date.toString()}- Notes: ${entry.notes}'),
            onTap: () {},
            trailing: IconButton(
              onPressed: () {
                onDelete(entry);
              },
              icon: Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
