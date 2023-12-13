import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddExercisePage extends StatefulWidget {
  Map? exercise;
  AddExercisePage({
    super.key,
    this.exercise,
  });

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController exercise_typeController = TextEditingController();
  TextEditingController burning_typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController burned_caloriesController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final exercise = widget.exercise;
    if (exercise != null) {
      print(2);
      print(exercise);
      isEdit = true;
      final name = exercise['name'];
      final exercise_type = exercise['exerciseType'];
      final description = exercise['description'];
      final burning_type = exercise['burningType'];
      final burned_calories = exercise['burnedCalories'];
      nameController.text = name;
      exercise_typeController.text = exercise_type;
      descriptionController.text = description;
      burning_typeController.text = burning_type;
      burned_caloriesController.text = burned_calories.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Exercise' : 'Add Exercise'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: exercise_typeController,
            decoration: InputDecoration(
                hintText: "Exercise_type: you choose 'CARDIO' or 'STRENGTH '"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          TextField(
            controller: burning_typeController,
            decoration: InputDecoration(
                hintText:
                    "Burning_type: you choose 'CALORIES_PER_HOUR' or 'CALORIES_PER_SET '"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: burned_caloriesController,
            decoration: InputDecoration(hintText: 'Burned_calories'),
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
    final exercise = widget.exercise;
    if (exercise == null) {
      print('you can not call update');
      return;
    }
    final id = exercise['id'];
    final name = nameController.text;
    final description = descriptionController.text;
    final burnedcalories = int.parse(burned_caloriesController.text);
    final body = {
      "name": name,
      "description": description,
      "burned_calories": burnedcalories
    };
    final url = 'https://fitness-app-e0xl.onrender.com/exercises/$id';
    final uri = Uri.parse(url);
    final response = await http.patch(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 204) {
      nameController.text = '';
      descriptionController.text = '';
      burned_caloriesController.text = '';
      showSuccessMessage('Update Success');
    } else {
      showErrorMessage('Update Failed');
    }
  }

  Future<void> submitdata() async {
    final name = nameController.text;
    final exercisetype = exercise_typeController.text;
    final description = descriptionController.text;
    final burningtype = burning_typeController.text;
    final burnedcalories = int.parse(burned_caloriesController.text);
    final body = {
      "name": name,
      "exercise_type": exercisetype,
      "burning_type": burningtype,
      "burned_calories": burnedcalories,
      "description": description,
    };
    final url = 'https://fitness-app-e0xl.onrender.com/exercises';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      nameController.text = '';
      exercise_typeController.text = '';
      descriptionController.text = '';
      burning_typeController.text = '';
      burned_caloriesController.text = '';
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
