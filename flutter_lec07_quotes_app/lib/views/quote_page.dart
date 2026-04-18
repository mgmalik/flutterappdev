import 'package:flutter/material.dart';
import 'package:flutter_lec07_quotes_app/models/quote.dart';
import 'package:flutter_lec07_quotes_app/viewmodels/quote_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuotePage extends ConsumerStatefulWidget {
  const QuotePage({super.key});

  @override
  ConsumerState<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends ConsumerState<QuotePage> {
  // Category checkboxes state
  final Map<String, bool> categories = {
    'wisdom': false,
    'philosophy': false,
    'inspirational': false,
    'faith': false,
    'success': false,
    'courage': false,
  };

  String _getCategories() {
    Iterable<MapEntry<String, bool>> trueEntries = categories.entries.where(
      (e) => e.value == true,
    );
    Iterable<String> keys = trueEntries.map((e) => e.key);
    return keys.join(',');
  }

  final TextEditingController _numberController = TextEditingController();
  int _currentValue = 1;

  @override
  void initState() {
    super.initState();
    _numberController.text = '1';
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _incrementNumber() {
    if (_currentValue < 10) {
      setState(() {
        _currentValue++;
        _numberController.text = _currentValue.toString();
      });
    }
  }

  void _decrementNumber() {
    if (_currentValue > 1) {
      setState(() {
        _currentValue--;
        _numberController.text = _currentValue.toString();
      });
    }
  }

  void _onNumberChanged(String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null) {
      if (newValue >= 1 && newValue <= 10) {
        setState(() {
          _currentValue = newValue;
        });
      } else {
        // Reset to current value if out of bounds
        _numberController.text = _currentValue.toString();
      }
    } else if (value.isEmpty) {
      // Don't update state for empty input
    } else {
      // Reset to current value if invalid
      _numberController.text = _currentValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quote App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Joke Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: categories.keys.map((category) {
                return CheckboxListTile(
                  title: Text(category),
                  value: categories[category],
                  onChanged: (bool? value) {
                    setState(() {
                      categories[category] = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Number of Jokes (1-10):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Decrement Button
                IconButton(
                  onPressed: _decrementNumber,
                  icon: const Icon(Icons.remove_circle),
                  color: Colors.blue,
                  iconSize: 32,
                ),

                // Number Input Field
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: '1-10',
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: _onNumberChanged,
                  ),
                ),

                // Increment Button
                IconButton(
                  onPressed: _incrementNumber,
                  icon: const Icon(Icons.add_circle),
                  color: Colors.blue,
                  iconSize: 32,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Get Quotes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(quoteViewModel.notifier).loadQuoteOfDay();
                  },
                  child: Text('Quote of Day'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final catString = _getCategories();
                    ref
                        .read(quoteViewModel.notifier)
                        .loadQuotes(
                          categories: catString,
                          qLimit: _currentValue,
                        );
                  },
                  child: Text('Quotes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final catString = _getCategories();

                    ref
                        .read(quoteViewModel.notifier)
                        .loadRandomQuotes(categories: catString);
                  },
                  child: Text('Random'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(child: _buildQuotesList()),
          ],
        ),
      ),
    );
  }

  // Build quotes list based on state
  Widget _buildQuotesList() {
    final quotes = ref.watch(quoteViewModel).value;
    if (quotes == null || quotes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircularProgressIndicator(),
            // SizedBox(height: 16),
            Text(
              'No quotes yet.\nSelect categories and tap "Get Quotes" to fetch quotes.',
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return _buildQuoteCard(quote, index);
      },
    );
  }

  // Build individual quote card
  Widget _buildQuoteCard(Quote quote, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote number indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Quote #${index + 1}',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Quote text
            Text(
              '"${quote.quote}"',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 12),

            // Author
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '- ${quote.author}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Categories
            if (quote.categories.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: quote.categories.map((category) {
                  return Chip(
                    label: Text(category, style: const TextStyle(fontSize: 12)),
                    backgroundColor: Colors.grey[200],
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
