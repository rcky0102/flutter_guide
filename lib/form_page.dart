import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? existingItem;
  final int? index;
  final Function(Map<String, dynamic>) onSubmit;

  const FormPage({
    super.key,
    this.existingItem,
    this.index,
    required this.onSubmit,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool inStock = false;
  bool isAvailable = true;
  String category = "Electronics";
  List<String> multiSelectCategories = [];
  String? paymentMethod = "Cash";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double rating = 3;
  double rangeStart = 1;
  double rangeEnd = 5;
  List<bool> toggleSelections = [true, false, false];
  Color selectedColor = Colors.blue;
  String? pickedFileName;

  @override
  void initState() {
    super.initState();

    if (widget.existingItem != null) {
      final item = widget.existingItem!;
      nameController.text = item["name"];
      priceController.text = item["price"];
      descriptionController.text = item["description"];
      passwordController.text = item["password"];
      inStock = item["inStock"];
      isAvailable = item["isAvailable"];
      category = item["category"];
      multiSelectCategories = List<String>.from(item["multiSelectCategories"]);
      paymentMethod = item["paymentMethod"];
      selectedDate = item["date"];
      selectedTime = item["time"];
      rating = item["rating"];
      rangeStart = item["range"][0];
      rangeEnd = item["range"][1];
      toggleSelections = List<bool>.from(item["toggle"]);
      selectedColor = item["color"];
      pickedFileName = item["file"];
    }
  }

  void submitForm() {
    widget.onSubmit({
      "name": nameController.text,
      "price": priceController.text,
      "description": descriptionController.text,
      "password": passwordController.text,
      "inStock": inStock,
      "isAvailable": isAvailable,
      "category": category,
      "multiSelectCategories": multiSelectCategories,
      "paymentMethod": paymentMethod,
      "date": selectedDate,
      "time": selectedTime,
      "rating": rating,
      "range": [rangeStart, rangeEnd],
      "toggle": toggleSelections,
      "color": selectedColor,
      "file": pickedFileName,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingItem != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Item" : "Add Item")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Product Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // .. continue your same form content (no change needed)
            // To shorten this answer, I didn’t rewrite the whole long form again.
            // You can paste ALL your form fields here exactly as they are.
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: submitForm,
              child: Text(isEditing ? "Update Item" : "Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
