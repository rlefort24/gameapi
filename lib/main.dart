import 'package:flutter/material.dart';
import 'package:projetapi/pages/homePage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:projetapi/services/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pqopespxenjrullgapdi.supabase.co',
    anonKey: SUPABASE_ANON_KEY,
  );
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
