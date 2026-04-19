import 'package:flutter/material.dart';
import '../classes/Machine.dart';
import '../widgets/ResourceCard.dart';
import '../widgets/SnackbarHelper.dart';

class ResourcesPage extends StatefulWidget {
  final Machine machine;
  
  const ResourcesPage({super.key, required this.machine});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedResource = 'coffeeBeans';
  
  // Словарь для отображения названий ресурсов
  final Map<String, String> resourceNames = {
    'coffeeBeans': 'Кофе',
    'milk': 'Молоко',
    'water': 'Вода',
  };
  
  // Словарь для иконок ресурсов
  final Map<String, IconData> resourceIcons = {
    'coffeeBeans': Icons.coffee,
    'milk': Icons.emoji_food_beverage,
    'water': Icons.water_drop,
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _addResource() {
    final amount = int.tryParse(_amountController.text);
    
    if (amount == null || amount <= 0) {
      SnackbarHelper.showError(context, 'Введите корректное количество');
      return;
    }
    
    setState(() {
      switch (_selectedResource) {
        case 'coffeeBeans':
          widget.machine.resources.coffeeBeans += amount;
          break;
        case 'milk':
          widget.machine.resources.milk += amount;
          break;
        case 'water':
          widget.machine.resources.water += amount;
          break;
      }
    });
    
    _amountController.clear();
    SnackbarHelper.showSuccess(
      context, 
      'Добавлено $amount ${resourceNames[_selectedResource]}'
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Дисплей для отображения ресурсов
          Card(
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Текущие ресурсы',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ResourceCard(
                    icon: Icons.coffee,
                    title: 'Кофе',
                    value: widget.machine.resources.coffeeBeans,
                    unit: 'гр',
                    color: Colors.brown,
                  ),
                  const SizedBox(height: 10),
                  ResourceCard(
                    icon: Icons.emoji_food_beverage,
                    title: 'Молоко',
                    value: widget.machine.resources.milk,
                    unit: 'мл',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  ResourceCard(
                    icon: Icons.water_drop,
                    title: 'Вода',
                    value: widget.machine.resources.water,
                    unit: 'мл',
                    color: Colors.cyan,
                  ),
                  const SizedBox(height: 10),
                  ResourceCard(
                    icon: Icons.attach_money,
                    title: 'Деньги',
                    value: widget.machine.resources.cash,
                    unit: 'руб',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Панель управления для добавления ресурсов
          Card(
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Добавить ресурсы',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Выбор ресурса
                  DropdownButtonFormField<String>(
                    value: _selectedResource,
                    decoration: InputDecoration(
                      labelText: 'Выберите ресурс',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: resourceNames.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Row(
                          children: [
                            Icon(resourceIcons[entry.key], size: 20),
                            const SizedBox(width: 10),
                            Text(entry.value),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedResource = value!;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Поле ввода количества
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Количество',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Введите количество',
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Кнопка добавления
                  ElevatedButton.icon(
                    onPressed: _addResource,
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}