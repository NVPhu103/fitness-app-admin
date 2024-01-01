import 'package:fitness_app_admin/screen/dashboard/dashboard_screens.dart';
import 'package:fitness_app_admin/screen/food/add_page.dart';
import 'package:fitness_app_admin/screen/food/fitnesspal_list.dart';
import 'package:fitness_app_admin/screen/nutrition/select_food_screen.dart';
import 'package:fitness_app_admin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../exercise/add_exercise.dart';
import '../exercise/exercise_list.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(flex: 5, child: DashboardScreen()),
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/logos/fines.jpg"),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/dashboard.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Food",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FitnessPallistPage();
                    },
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Nutrition",
              svgSrc: "assets/icons/Hamburger.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SelectFoodScreen();
                    },
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Excrecises",
              svgSrc: "assets/icons/Excrecises.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ExerciselistPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });
  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
