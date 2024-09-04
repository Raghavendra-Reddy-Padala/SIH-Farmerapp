import 'package:farmerapp/intro_pages/on_boarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InstaFarm',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const OnboardingScreen());
  }
}
