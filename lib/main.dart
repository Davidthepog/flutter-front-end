// import 'package:flutter/material.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_application_1/main_page.dart';

//import 'package:http/http.dart' as https;

//var url=Uri.http('https://localhost:7052/api/utenze');

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}
