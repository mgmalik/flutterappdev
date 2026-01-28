import 'dart:async';

import 'package:flutter_lec05_expense_tracking_app_riverpod/models/tag.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/services/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagNotifier extends AsyncNotifier<List<Tag>> {
  final LocalStorageService storageService = LocalStorageService();
  @override
  FutureOr<List<Tag>> build() {
    return _loadTags();
  }

  Future<List<Tag>> _loadTags() async {
    final List<Tag> loadedCategories = storageService.getTagsList();
    return loadedCategories;
  }

  Future<void> addTag(Tag tag) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = [...current, tag];
      state = AsyncData(updated);
      await storageService.saveTagsList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeTag(Tag tag) async {
    state = const AsyncLoading();
    try {
      final current = state.value ?? [];
      final updated = current.where((t) => t.id != tag.id).toList();
      state = AsyncData(updated);
      await storageService.saveTagsList(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final tagsProvider = AsyncNotifierProvider<TagNotifier, List<Tag>>(
  TagNotifier.new,
);
