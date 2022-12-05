import 'package:flutter/material.dart';
import 'package:zigy/pages/add_user.dart';
import 'package:zigy/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/addUser': (context) => const AddUser(),
      },
    );
  }
}
