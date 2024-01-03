import 'dart:convert';
import 'package:flutter/material.dart';
import 'add_exercise.dart';
import 'package:http/http.dart' as http;

class ExerciselistPage extends StatefulWidget {
  const ExerciselistPage({super.key});

  @override
  State<ExerciselistPage> createState() => _ExerciselistPageState();
}

class _ExerciselistPageState extends State<ExerciselistPage> {
  bool isLoading = true;
  List items = [];

  get jsonMap => null;
  @override
  void initState() {
    super.initState();
    fetchExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exersice List'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchExercise,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['id'] as String;

              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['name']),
                subtitle: Text(item['description'] + " burned_calories "),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      print(item);
                      // open edit page
                      navigateToEditPage(item);
                      // } else if (value == 'delete') {
                      //   // delete and remove the items
                      //   deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      // PopupMenuItem(
                      //   child: Text('Delete'),
                      //   value: 'delete',
                      // ),
                    ];
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToaddPage,
        label: const Text('Add Exercise'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    // print(1);
    // print(item);
    final route = MaterialPageRoute(
      builder: (context) => AddExercisePage(exercise: item),
    );
    Navigator.push(context, route);
  }

  Future<void> navigateToaddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddExercisePage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchExercise();
  }

  // Future<void> deleteById(String id) async {
  //   //delete the item
  //   // print(id);
  //   final url = 'https://fitness-app-e0xl.onrender.com/foods/delete/$id';
  //   final uri = Uri.parse(url);
  //   final response = await http.patch(uri);
  //   if (response.statusCode == 204) {
  //     // remove item from list
  //     final filtered = items.where((element) => element['id'] != id).toList();
  //     setState(() {
  //       items = filtered;
  //     });
  //   } else {
  //     showErrorMessage('Deletion Failed');
  //   }
  // }

  Future<void> fetchExercise() async {
    final url =
        'https://fitness-app-e0xl.onrender.com/exercises?page=1&per_page=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));

      setState(() {
        items = json;
      });
    } else {
      //show error
    }
    setState(() {
      isLoading = false;
    });
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
