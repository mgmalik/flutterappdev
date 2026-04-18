import 'dart:async';

import 'package:flutter_lec07_quotes_app/models/quote.dart';
import 'package:flutter_lec07_quotes_app/services/quote_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuoteViewModel extends AsyncNotifier<List<Quote>> {
  final QuoteService apiService = QuoteService();
  @override
  FutureOr<List<Quote>> build() {
    return _loadQuoteOfDay();
  }

  Future<List<Quote>> _loadQuoteOfDay() async {
    return await apiService.fetchQuoteOfDay();
  }

  Future<void> loadQuotes({
    String categories = 'wisdom',
    int qLimit = 1,
  }) async {
    state = const AsyncLoading();
    try {
      final updated = await apiService.fetchQuotes(categories, qLimit);
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadQuoteOfDay() async {
    state = const AsyncLoading();
    try {
      final updated = await apiService.fetchQuoteOfDay();
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadRandomQuotes({String categories = 'wisdom'}) async {
    state = const AsyncLoading();
    try {
      final updated = await apiService.fetchRandomQuotes(categories);
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final quoteViewModel = AsyncNotifierProvider<QuoteViewModel, List<Quote>>(
  QuoteViewModel.new,
);
