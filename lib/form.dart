import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  List<Map<String, dynamic>> items = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  int? editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Product details"),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
