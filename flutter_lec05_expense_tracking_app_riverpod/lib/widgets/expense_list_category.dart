import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseListCategroy extends StatelessWidget {
  const ExpenseListCategroy({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, List<Expense>>> entries =
        groupByCategoryExpenseList();
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          elevation: 8.0,
          shadowColor: Colors.blueGrey,
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(
              entry.keys.first,
              style: TextStyle(
                color: Constants.appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entry.values.first
                  .map(
                    (item) => Text(
                      '- ${item.categoryId}: ${item.amount} (${DateFormat('MMM dd, yyyy').format(item.date)})',
                    ),
                  )
                  .toList(),
            ),
            // subtitle: Text('${entry.date.toString()}- Notes: ${entry.notes}'),
            onTap: () {},
            trailing: IconButton(
              onPressed: () {
                // context.read<TimeTrackerProvider>().deleteTimeEntry(entry.id);
              },
              icon: Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, List<Expense>>> groupByCategoryExpenseList() {
    final result = <Map<String, List<Expense>>>[];
    final categoryIndexMap = <String, int>{};

    for (final entry in expenses) {
      final categoryId = entry.categoryId;
      if (categoryIndexMap.containsKey(categoryId)) {
        final index = categoryIndexMap[categoryId]!;
        final categoryMap = result[index];
        categoryMap[categoryId]!.add(entry);
      } else {
        categoryIndexMap[categoryId] = result.length;
        result.add({
          categoryId: [entry],
        });
      }
    }

    return result;
  }
}
