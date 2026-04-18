import 'dart:convert';

import 'package:flutter_lec07_quotes_app/env.dart';
import 'package:flutter_lec07_quotes_app/models/quote.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  final String baseUrl = 'https://api.api-ninjas.com';

  Future<List<Quote>> fetchQuoteOfDay() async {
    final String quoteUrl = '/v2/quoteoftheday';
    final response = await http.get(
      Uri.parse(baseUrl + quoteUrl),
      headers: {'X-Api-Key': Env.apiKey},
    );
    if (response.statusCode == 200) {
      List<dynamic> quotesListJson = jsonDecode(response.body);
      return quotesListJson
          .map((q) => Quote.fromJson(q as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Quote>> fetchQuotes(String categories, int qLimit) async {
    final String quoteUrl = '/v2/quotes?categories=$categories&limit=$qLimit';
    final response = await http.get(
      Uri.parse(baseUrl + quoteUrl),
      headers: {'X-Api-Key': Env.apiKey},
    );
    if (response.statusCode == 200) {
      List<dynamic> quotesListJson = jsonDecode(response.body);
      return quotesListJson
          .map((q) => Quote.fromJson(q as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Quote>> fetchRandomQuotes(String categories) async {
    final String quoteUrl = '/v2/randomquotes?categories=$categories';
    final response = await http.get(
      Uri.parse(baseUrl + quoteUrl),
      headers: {'X-Api-Key': Env.apiKey},
    );
    if (response.statusCode == 200) {
      List<dynamic> quotesListJson = jsonDecode(response.body);
      return quotesListJson
          .map((q) => Quote.fromJson(q as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
