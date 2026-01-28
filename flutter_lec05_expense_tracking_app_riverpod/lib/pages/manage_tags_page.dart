import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/tag.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/providers/tag_notifier.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/widgets/text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTagsPage extends ConsumerWidget {
  const ManageTagsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsData = ref.watch(tagsProvider).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appColor,
        title: Text(
          'Manage Tags',
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
      body: (tagsData == null || tagsData.isEmpty)
          ? Center(child: Text('Click on the + button to add a tag'))
          : ListView.builder(
              itemCount: tagsData.length,
              itemBuilder: (context, index) {
                final tag = tagsData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 8.0,
                  shadowColor: Constants.cardShadowColor,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(tag.name),
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(tagsProvider.notifier).removeTag(tag);
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
          _showTagInputDialog(context, ref);
        },
        tooltip: 'Add Category',
        child: Icon(Icons.add, color: Constants.textColorWithBackground),
      ),
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
