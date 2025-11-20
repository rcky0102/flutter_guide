import 'package:flutter/material.dart';
import 'form_page.dart';
import 'table_page.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List<Map<String, dynamic>> items = [];

  void addItem(Map<String, dynamic> newItem) {
    setState(() => items.add(newItem));
  }

  void updateItem(int index, Map<String, dynamic> updatedItem) {
    setState(() => items[index] = updatedItem);
  }

  void deleteItem(int index) {
    setState(() => items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD Example")),
      body: TablePage(
        items: items,
        onDelete: deleteItem,
        onEdit: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormPage(
                existingItem: items[index],
                index: index,
                onSubmit: (updatedItem) {
                  updateItem(index, updatedItem);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormPage(onSubmit: addItem)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
