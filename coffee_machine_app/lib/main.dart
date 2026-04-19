import 'package:flutter/material.dart';
import 'classes/Resources.dart';
import 'classes/Machine.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(const CoffeeMachineApp());
}

class CoffeeMachineApp extends StatelessWidget {
  const CoffeeMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Создаем начальные ресурсы
    final resources = Resources(
      coffeeBeans: 100,
      milk: 200,
      water: 300,
      cash: 0,
    );
    
    final machine = Machine(resources: resources);

    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(machine: machine),
    );
  }
}