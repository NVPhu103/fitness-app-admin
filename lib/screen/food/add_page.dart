import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddFitnessPalPage extends StatefulWidget {
  Map? fitnesspal;
  AddFitnessPalPage({
    super.key,
    this.fitnesspal,
  });

  @override
  State<AddFitnessPalPage> createState() => _AddFitnessPalPageState();
}

class _AddFitnessPalPageState extends State<AddFitnessPalPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final fitnesspal = widget.fitnesspal;
    if (fitnesspal != null) {
      isEdit = true;
      final name = fitnesspal['name'];
      final calories = fitnesspal['calories'];
      final unit = fitnesspal['unit'];
      nameController.text = name;
      caloriesController.text = calories.toString();
      unitController.text = unit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit fitnesspal' : 'Add FitnessPal'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'name'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: unitController,
            decoration: InputDecoration(
                hintText: "unit of the food (e.g. a bowl, 100 gram, a cup)"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: caloriesController,
            decoration: InputDecoration(hintText: 'calories'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateDate : submitdata,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateDate() async {
    final fitnesspal = widget.fitnesspal;
    if (fitnesspal == null) {
      print('you can not call update');
      return;
    }
    final id = fitnesspal['id'];
    final status = fitnesspal['status'];
    final name = nameController.text;
    final calories = int.parse(caloriesController.text);
    final unit = unitController.text;
    final body = {
      "name": name,
      "calories": calories,
      "unit": unit,
      "status": status,
    };
    final url = 'http://127.0.0.1:8000/foods/$id';
    final uri = Uri.parse(url);
    final response = await http.patch(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 204) {
      nameController.text = '';
      caloriesController.text = '';
      unitController.text = '';
      showSuccessMessage('Update Success');
    } else {
      showErrorMessage('Update Failed');
    }
  }

  Future<void> submitdata() async {
    final name = nameController.text;
    final calories = int.parse(caloriesController.text);
    final unit = unitController.text;
    final body = {
      "name": name,
      "calories": calories,
      "unit": unit,
      // "status": false,
    };
    final url = 'http://127.0.0.1:8000/foods';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      nameController.text = '';
      caloriesController.text = '';
      unitController.text = '';
      showSuccessMessage('Creation Success');
    } else {
      showErrorMessage('Creation Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
