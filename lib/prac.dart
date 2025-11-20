import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List<Map<String, dynamic>> items = [];

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Other form states
  bool inStock = false;
  bool isAvailable = true; // Switch
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

  int? editingIndex;

  void addItem() {
    if (nameController.text.isEmpty || priceController.text.isEmpty) return;

    setState(() {
      items.add({
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
    });

    clearForm();
  }

  void updateItem() {
    if (editingIndex == null) return;

    setState(() {
      items[editingIndex!] = {
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
      };
    });

    clearForm();
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void loadItemForEditing(int index) {
    final item = items[index];
    setState(() {
      editingIndex = index;
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
    });
  }

  void clearForm() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    passwordController.clear();
    inStock = false;
    isAvailable = true;
    category = "Electronics";
    multiSelectCategories.clear();
    paymentMethod = "Cash";
    selectedDate = null;
    selectedTime = null;
    rating = 3;
    rangeStart = 1;
    rangeEnd = 5;
    toggleSelections = [true, false, false];
    selectedColor = Colors.blue;
    pickedFileName = null;
    editingIndex = null;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> pickColor(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pick a color"),
        content: BlockPicker(
          pickerColor: selectedColor,
          onColorChanged: (color) => setState(() => selectedColor = color),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full CRUD Form"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Single-line text
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Number
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Multiline text
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Checkbox
              Row(
                children: [
                  const Text("In Stock: "),
                  Checkbox(
                    value: inStock,
                    onChanged: (val) => setState(() => inStock = val ?? false),
                  ),
                ],
              ),

              // Switch
              Row(
                children: [
                  const Text("Available: "),
                  Switch(
                    value: isAvailable,
                    onChanged: (val) => setState(() => isAvailable = val),
                  ),
                ],
              ),

              // Radio
              Row(
                children: [
                  const Text("Payment: "),
                  Radio<String>(
                    value: "Cash",
                    groupValue: paymentMethod,
                    onChanged: (val) => setState(() => paymentMethod = val),
                  ),
                  const Text("Cash"),
                  Radio<String>(
                    value: "Card",
                    groupValue: paymentMethod,
                    onChanged: (val) => setState(() => paymentMethod = val),
                  ),
                  const Text("Card"),
                ],
              ),

              // Dropdown
              Row(
                children: [
                  const Text("Category: "),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: category,
                    items: <String>["Electronics", "Clothes", "Food", "Books"]
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (val) => setState(() => category = val!),
                  ),
                ],
              ),

              // Multi-select categories (checkboxes)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Multiple Categories:"),
                  Wrap(
                    spacing: 8,
                    children: ["Electronics", "Clothes", "Food", "Books"]
                        .map(
                          (cat) => FilterChip(
                            label: Text(cat),
                            selected: multiSelectCategories.contains(cat),
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  multiSelectCategories.add(cat);
                                } else {
                                  multiSelectCategories.remove(cat);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),

              // Date picker
              Row(
                children: [
                  const Text("Date: "),
                  Text(
                    selectedDate != null
                        ? "${selectedDate!.toLocal()}".split(" ")[0]
                        : "Not selected",
                  ),
                  TextButton(
                    onPressed: () => pickDate(context),
                    child: const Text("Pick Date"),
                  ),
                ],
              ),

              // Time picker
              Row(
                children: [
                  const Text("Time: "),
                  Text(
                    selectedTime != null
                        ? selectedTime!.format(context)
                        : "Not selected",
                  ),
                  TextButton(
                    onPressed: () => pickTime(context),
                    child: const Text("Pick Time"),
                  ),
                ],
              ),

              // Slider
              Row(
                children: [
                  const Text("Rating: "),
                  Expanded(
                    child: Slider(
                      value: rating,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: rating.toString(),
                      onChanged: (val) => setState(() => rating = val),
                    ),
                  ),
                ],
              ),

              // Range slider
              Column(
                children: [
                  const Text("Range:"),
                  RangeSlider(
                    values: RangeValues(rangeStart, rangeEnd),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    labels: RangeLabels(
                      rangeStart.toString(),
                      rangeEnd.toString(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        rangeStart = val.start;
                        rangeEnd = val.end;
                      });
                    },
                  ),
                ],
              ),

              // Toggle buttons
              Row(
                children: [
                  const Text("Toggle: "),
                  ToggleButtons(
                    children: const [Text("A"), Text("B"), Text("C")],
                    isSelected: toggleSelections,
                    onPressed: (i) {
                      setState(() {
                        toggleSelections[i] = !toggleSelections[i];
                      });
                    },
                  ),
                ],
              ),

              // Color picker
              Row(
                children: [
                  const Text("Color: "),
                  Container(width: 24, height: 24, color: selectedColor),
                  TextButton(
                    onPressed: () => pickColor(context),
                    child: const Text("Pick Color"),
                  ),
                ],
              ),

              // File picker (placeholder)
              Row(
                children: [
                  const Text("File: "),
                  Text(pickedFileName ?? "No file selected"),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pickedFileName = "example_file.txt";
                      });
                    },
                    child: const Text("Pick File"),
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: editingIndex == null ? addItem : updateItem,
                child: Text(editingIndex == null ? "Add Item" : "Update Item"),
              ),

              const SizedBox(height: 20),
              const Text(
                "Items List",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item["name"]),
                      subtitle: Text(
                        "₱${item["price"]} | ${item["category"]} | ${item["paymentMethod"]} | In stock: ${item["inStock"]} | Available: ${item["isAvailable"]} | Rating: ${item["rating"]} | Date: ${item["date"] != null ? item["date"].toString().split(" ")[0] : 'N/A'} | Time: ${item["time"] != null ? item["time"].format(context) : 'N/A'} | Color: ${item["color"]} | File: ${item["file"]}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => loadItemForEditing(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
