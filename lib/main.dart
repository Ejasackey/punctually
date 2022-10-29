import 'package:flutter/material.dart';
import 'package:punctually/screens/home.dart';
import 'package:punctually/screens/report.dart';
import 'package:punctually/style.dart';

void main() {
  runApp(const App());
}

const homeRoute = "/";
const reportScreenRoute = "/report_screen";

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punctually',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: PrimaryColor),
      ),
      home: HomeScreen(),
    );
  }
}
