import 'dart:async';

import 'package:flutter_lec05_expense_tracking_app_riverpod/models/category.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/services/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends AsyncNotifier<List<Category>> {
  final LocalStorageService storageService = LocalStorageService();
  @override
  FutureOr<List<Category>> build() {
    return _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    final List<Category> loadedCategories = storageService.getCategoriesList();
    return loadedCategories;
  }

  Future<void> addCategory(Category category) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = [...current, category];
      state = AsyncData(updated);
      await storageService.saveCategoriesList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeCategory(Category category) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = current.where((c) => c.id != category.id).toList();
      state = AsyncData(updated);
      await storageService.saveCategoriesList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final categoriesProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(
      CategoryNotifier.new,
    );
