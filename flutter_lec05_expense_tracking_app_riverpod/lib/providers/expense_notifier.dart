import 'dart:async';

import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/services/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends AsyncNotifier<List<Expense>> {
  final LocalStorageService storageService = LocalStorageService();

  @override
  FutureOr<List<Expense>> build() {
    return _loadExpnses();
  }

  Future<List<Expense>> _loadExpnses() async {
    final List<Expense> loadedExpenses = storageService.getExpensesList();
    return loadedExpenses;
  }

  Future<void> addExpense(Expense expense) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = [...current, expense];
      state = AsyncData(updated);
      await storageService.saveExpensesList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeExpense(Expense expense) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = current.where((e) => e.id != expense.id).toList();
      state = AsyncData(updated);
      await storageService.saveExpensesList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// provider for the expenses
final expenseProvider = AsyncNotifierProvider<ExpenseNotifier, List<Expense>>(
  ExpenseNotifier.new,
);
