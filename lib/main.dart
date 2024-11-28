import 'package:flutter/material.dart';
import './widgets/sign_in_screen.dart';

GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
GlobalKey<FormState> singupFormKey = GlobalKey<FormState>();
GlobalKey<FormState> singinFormKey = GlobalKey<FormState>();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home:  SignInScreen(),
    );
  }
}

