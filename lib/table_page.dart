import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(int) onDelete;
  final Function(int) onEdit;

  const TablePage({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(child: Text("No items yet"))
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Card(
                child: ListTile(
                  title: Text(item["name"]),
                  subtitle: Text("₱${item["price"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onEdit(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onDelete(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
