import 'package:flutter/material.dart';
import '../classes/Machine.dart';
import 'ResourcesPage.dart';
import 'CoffeePage.dart';

class HomePage extends StatefulWidget {
  final Machine machine;
  
  const HomePage({super.key, required this.machine});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кофемашина'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.coffee), text: 'Приготовление'),
            Tab(icon: Icon(Icons.inventory), text: 'Ресурсы'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CoffeePage(machine: widget.machine),
          ResourcesPage(machine: widget.machine),
        ],
      ),
    );
  }
}