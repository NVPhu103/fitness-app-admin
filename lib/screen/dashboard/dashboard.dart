import 'package:fitness_app_admin/screen/food/add_page.dart';
import 'package:fitness_app_admin/screen/food/fitnesspal_list.dart';
import 'package:fitness_app_admin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DASHBOARD',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return const FitnessPallistPage();
  }
}
