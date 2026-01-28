import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/category.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/category_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageCategoriesPage extends ConsumerWidget {
  const ManageCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesData = ref.watch(categoriesProvider).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appColor,
        title: Text(
          'Manage Categories',
          style: TextStyle(color: Constants.textColorWithBackground),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Constants.textColorWithBackground,
          ),
        ),
      ),
      body: (categoriesData == null || categoriesData.isEmpty)
          ? Center(child: Text('Click on the + button to add a category'))
          : ListView.builder(
              itemCount: categoriesData.length,
              itemBuilder: (context, index) {
                final category = categoriesData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 8.0,
                  shadowColor: Constants.cardShadowColor,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(categoriesProvider.notifier)
                            .removeCategory(category);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.appColor,
        onPressed: () {
          _showCategoryInputDialog(context, ref);
        },
        tooltip: 'Add Category',
        child: Icon(Icons.add, color: Constants.textColorWithBackground),
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
}
