import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/category.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/tag.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/category_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/expense_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/tag_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key});

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController payeeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late Category selectedCategory;
  late Tag selectedTag;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    setState(() {
      if (pickedDate != null) {
        selectedDate = pickedDate;
      }
    });
  }

  Future<void> _saveExpense(BuildContext context) async {
    Expense expense = Expense(
      id: DateTime.now().toIso8601String(),
      amount: double.tryParse(amountController.text)!,
      categoryId: selectedCategory.id,
      payee: payeeController.text,
      note: noteController.text,
      date: selectedDate,
      tagId: selectedTag.id,
    );
    try {
      await ref.read(expenseProvider.notifier).addExpense(expense);
      Navigator.of(context).pop();
    } catch (e) {
      print('Failed to add category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = ref.watch(categoriesProvider).value;
    final tagsData = ref.watch(tagsProvider).value;
    List<DropdownMenuEntry<Category>> categoryEntires = [];
    List<DropdownMenuEntry<Tag>> tagEntires = [];
    if (categoriesData != null && categoriesData.isNotEmpty) {
      categoryEntires = categoriesData
          .map<DropdownMenuEntry<Category>>(
            (Category category) => DropdownMenuEntry<Category>(
              value: category,
              label: category.name,
            ),
          )
          .toList();
      selectedCategory = categoriesData[0];
    }

    if (tagsData != null && tagsData.isNotEmpty) {
      tagEntires = tagsData
          .map<DropdownMenuEntry<Tag>>(
            (Tag tag) => DropdownMenuEntry<Tag>(value: tag, label: tag.name),
          )
          .toList();
      selectedTag = tagsData[0];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appColor,
        title: Text(
          'Add Expense',
          style: TextStyle(color: Constants.textColorWithBackground),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Constants.textColorWithBackground,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextfieldWidget(controller: amountController, title: 'Amount'),
            SizedBox(height: 24),
            TextfieldWidget(controller: payeeController, title: 'Payee'),
            SizedBox(height: 24),
            TextfieldWidget(controller: noteController, title: 'Note'),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                _selectDate();
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${selectedDate.day} : ${selectedDate.month} : ${selectedDate.year}',
                      style: TextStyle(
                        color: Constants.appColor,
                        fontSize: 14.0,
                      ),
                    ),
                    Icon(Icons.date_range),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            categoryEntires.isNotEmpty
                ? DropdownMenu(
                    expandedInsets: EdgeInsets.zero,
                    label: Text('Select Category'),
                    initialSelection: selectedCategory,
                    onSelected: (Category? category) {
                      if (category != null) {
                        selectedCategory = category;
                      }
                    },
                    dropdownMenuEntries: categoryEntires,
                    textStyle: TextStyle(
                      color: Constants.appColor,
                      fontSize: 14.0,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      labelStyle: TextStyle(color: Constants.appColor),
                      focusColor: Constants.appColor,
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Constants.appColor),
                      ),
                    ),
                  )
                : const Text('No category, please add one.'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showCategoryInputDialog(context, ref);
              },
              label: Text(
                'Add new Category',
                style: TextStyle(color: Constants.appColor, fontSize: 14.0),
              ),
              icon: Icon(Icons.add),
            ),
            const SizedBox(height: 24),
            tagEntires.isNotEmpty
                ? DropdownMenu(
                    expandedInsets: EdgeInsets.zero,
                    label: Text('Select Tag'),
                    initialSelection: selectedTag,
                    onSelected: (Tag? tag) {
                      if (tag != null) {
                        selectedTag = tag;
                      }
                    },
                    dropdownMenuEntries: tagEntires,
                    textStyle: TextStyle(
                      color: Constants.appColor,
                      fontSize: 14.0,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      labelStyle: TextStyle(color: Constants.appColor),
                      focusColor: Constants.appColor,
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Constants.appColor),
                      ),
                    ),
                  )
                : const Text('No category, please add one.'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showTagInputDialog(context, ref);
              },
              label: Text(
                'Add new Tag',
                style: TextStyle(color: Constants.appColor, fontSize: 14.0),
              ),
              icon: Icon(Icons.add),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: () {
                  _saveExpense(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Constants.appColor,
                  foregroundColor: Constants.textColorWithBackground,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Add Expense',
                    style: TextStyle(
                      color: Constants.textColorWithBackground,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCategoryInputDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // 1. Create a TextEditingController to manage the input
    final TextEditingController textFieldController = TextEditingController();

    // 2. Use showDialog to display the dialog
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: TextfieldWidget(
            controller: textFieldController,
            title: 'Category',
          ),
          actions: <Widget>[
            // 3. Define the Cancel button
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                // Close the dialog without returning any data
                Navigator.pop(context);
              },
            ),
            // 4. Define the Add button
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                // Close the dialog and return the input text
                ref
                    .read(categoriesProvider.notifier)
                    .addCategory(
                      Category(
                        id: textFieldController.text,
                        name: textFieldController.text,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTagInputDialog(BuildContext context, WidgetRef ref) async {
    // 1. Create a TextEditingController to manage the input
    final TextEditingController textFieldController = TextEditingController();

    // 2. Use showDialog to display the dialog
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Tag'),
          content: TextfieldWidget(
            controller: textFieldController,
            title: 'Tag',
          ),
          actions: <Widget>[
            // 3. Define the Cancel button
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                // Close the dialog without returning any data
                Navigator.pop(context);
              },
            ),
            // 4. Define the Add button
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                // Close the dialog and return the input text
                ref
                    .read(tagsProvider.notifier)
                    .addTag(
                      Tag(
                        id: textFieldController.text,
                        name: textFieldController.text,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
