import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // ここで primarySwatch: Colors.white としたいけどエラーが出るため、それぞれのappBarでcolorを指定している。
        primarySwatch: Colors.indigo,
      ),
      home: const LoginPage(),
    );
  }
}
