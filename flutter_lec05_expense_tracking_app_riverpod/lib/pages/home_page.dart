import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/pages/add_expense_page.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/expense_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/drawer_widget.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/expense_list_category.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/expense_list_date.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/menu_icon_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseData = ref.watch(expenseProvider).value;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.appColor,
          title: Text(
            'Expense Tracker',
            style: TextStyle(color: Constants.textColorWithBackground),
          ),
          centerTitle: true,
          leading: MenuIconWidget(),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'By Date',
                  style: TextStyle(color: Constants.textColorWithBackground),
                ),
              ),
              Tab(
                child: Text(
                  'By Category',
                  style: TextStyle(color: Constants.textColorWithBackground),
                ),
              ),
            ],
          ),
        ),
        drawer: DrawerWidget(),
        body: (expenseData == null || expenseData.isEmpty)
            ? Center(child: Text('Click on the + button to record expenses.'))
            : TabBarView(
                children: [
                  ExpnseListDate(
                    expenses: expenseData,
                    onDelete: (Expense expense) {
                      ref.read(expenseProvider.notifier).removeExpense(expense);
                    },
                  ),
                  ExpenseListCategroy(expenses: expenseData),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.appColor,
          tooltip: 'Add Expense',
          child: Icon(Icons.add, color: Constants.textColorWithBackground),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddExpensePage()));
          },
        ),
      ),
    );
  }
}
