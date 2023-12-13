import 'dart:convert';
import 'package:flutter/material.dart';
import 'add_page.dart';
import 'package:http/http.dart' as http;

class FitnessPallistPage extends StatefulWidget {
  const FitnessPallistPage({super.key});

  @override
  State<FitnessPallistPage> createState() => _FitnessPallistPageState();
}

class _FitnessPallistPageState extends State<FitnessPallistPage> {
  bool isLoading = true;
  List items = [];

  get jsonMap => null;
  @override
  void initState() {
    super.initState();
    fetchFitnessPal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitnessPal List'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchFitnessPal,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 16,
              bottom: 72,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['id'] as String;

              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['name']),
                subtitle: Text(item['calories'].toString() +
                    " calories per " +
                    item['unit'].toString()),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      // open edit page
                      navigateToEditPage(item);
                    } else if (value == 'delete') {
                      // delete and remove the items
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 'delete',
                      ),
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
        label: const Text('Add Fitness'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddFitnessPalPage(fitnesspal: item),
    );
    Navigator.push(context, route);
  }

  Future<void> navigateToaddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddFitnessPalPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchFitnessPal();
  }

  Future<void> deleteById(String id) async {
    //delete the item
    print(id);
    final url = 'https://fitness-app-e0xl.onrender.com/foods/delete/$id';
    final uri = Uri.parse(url);
    final response = await http.patch(uri);
    if (response.statusCode == 204) {
      // remove item from list
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage('Deletion Failed');
    }
  }

  Future<void> fetchFitnessPal() async {
    final url =
        'https://fitness-app-e0xl.onrender.com/foods?status=ACTIVE&page=1&per_page=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json[0];
      print(json.runtimeType);
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
