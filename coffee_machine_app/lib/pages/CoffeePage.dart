import 'package:flutter/material.dart';
import '../classes/Machine.dart';
import '../classes/CoffeeMaker.dart';
import '../enums/CoffeeTypes.dart';
import '../widgets/CoffeeButton.dart';
import '../widgets/SnackbarHelper.dart';

class CoffeePage extends StatefulWidget {
  final Machine machine;
  
  const CoffeePage({super.key, required this.machine});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  bool _isMakingCoffee = false;

  void _showProgressMessage(BuildContext context, String message) {
    // Очищаем старые snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    
    // Показываем новое сообщение
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (message.contains('✅') || message.contains('🎉'))
              const Icon(Icons.check_circle, color: Colors.white, size: 20)
            else if (message.contains('🔥') || message.contains('☕️') || message.contains('🥛') || message.contains('🔄'))
              const Icon(Icons.info, color: Colors.white, size: 20)
            else
              const Icon(Icons.info, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: message.contains('✅') || message.contains('🎉') 
            ? Colors.green 
            : Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _makeCoffee(CoffeeType type, String name, bool hasMilk) async {
    if (_isMakingCoffee) {
      SnackbarHelper.showInfo(context, 'Кофе уже готовится, подождите');
      return;
    }
    
    setState(() {
      _isMakingCoffee = true;
    });
    
    try {
      // Проверяем ресурсы
      await widget.machine.checkResources(type);
      
      // Готовим кофе с всплывающими подсказками
      await widget.machine.makeCoffeeWithProgress(
        type, 
        (message) => _showProgressMessage(context, message)
      );
      
      SnackbarHelper.showSuccess(context, '$name готов! Приятного аппетита!');
      setState(() {}); // Обновляем UI
    } catch (e) {
      SnackbarHelper.showError(context, e.toString());
    } finally {
      setState(() {
        _isMakingCoffee = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Дисплей с текущими ресурсами
          Card(
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Доступные ресурсы',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildResourceChip(
                        Icons.coffee,
                        '${widget.machine.resources.coffeeBeans} гр',
                        Colors.brown,
                      ),
                      _buildResourceChip(
                        Icons.emoji_food_beverage,
                        '${widget.machine.resources.milk} мл',
                        Colors.blue,
                      ),
                      _buildResourceChip(
                        Icons.water_drop,
                        '${widget.machine.resources.water} мл',
                        Colors.cyan,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Панель управления с кнопками кофе
          Card(
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Выберите кофе',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  CoffeeButton(
                    name: 'Эспрессо',
                    price: 150,
                    ingredients: '50г кофе, 100мл воды',
                    icon: Icons.coffee,
                    color: Colors.brown,
                    onPressed: _isMakingCoffee 
                        ? null 
                        : () => _makeCoffee(CoffeeType.espresso, 'Эспрессо', false),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  CoffeeButton(
                    name: 'Капучино',
                    price: 200,
                    ingredients: '30г кофе, 150мл молока, 100мл воды',
                    icon: Icons.coffee_maker,
                    color: Colors.brown,
                    onPressed: _isMakingCoffee 
                        ? null 
                        : () => _makeCoffee(CoffeeType.cappuccino, 'Капучино', true),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  CoffeeButton(
                    name: 'Латте',
                    price: 250,
                    ingredients: '30г кофе, 200мл молока, 100мл воды',
                    icon: Icons.emoji_food_beverage,
                    color: Colors.brown,
                    onPressed: _isMakingCoffee 
                        ? null 
                        : () => _makeCoffee(CoffeeType.latte, 'Латте', true),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  CoffeeButton(
                    name: 'Американо',
                    price: 180,
                    ingredients: '40г кофе, 150мл воды',
                    icon: Icons.local_cafe,
                    color: Colors.brown,
                    onPressed: _isMakingCoffee 
                        ? null 
                        : () => _makeCoffee(CoffeeType.americano, 'Американо', false),
                  ),
                ],
              ),
            ),
          ),
          
          if (_isMakingCoffee)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Приготовление кофе...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildResourceChip(IconData icon, String text, Color color) {
    return Chip(
      avatar: Icon(icon, size: 20, color: color),
      label: Text(text),
      backgroundColor: color.withOpacity(0.1),
    );
  }
}