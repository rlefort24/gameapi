import 'package:flutter/material.dart';
import 'package:projetapi/pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameApi',
      theme: ThemeData(useSystemColors: true, useMaterial3: true),
      home: HomePage(title: 'GameApi'),
      routes: <String, WidgetBuilder>{},
      debugShowCheckedModeBanner: false,
    );
  }
}
