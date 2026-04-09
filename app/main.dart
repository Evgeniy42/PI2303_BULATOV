import 'dart:io';
import 'classes/Machine.dart';
import 'classes/Resources.dart';
import 'enums/CoffeeTypes.dart';

void main() async {
  Resources resources = Resources(
    coffeeBeans: 100,
    milk: 200,
    water: 300,
    cash: 0,
  );
  
  Machine machine = Machine(resources: resources);

  while (true) {
    print('=== КОФЕМАШИНА ===');
    print('\nДоступные команды:');
    print('  resources - показать ресурсы');
    print('  add - добавить ресурсы');
    print('  make - приготовить кофе');
    print('  exit - выход');
    print('=' * 50);

    stdout.write('\nВведите команду: ');
    String command = stdin.readLineSync()?.toLowerCase() ?? '';

    switch (command) {
      case 'resources':
        machine.showResources();
        break;
        
      case 'add':
        await _fillResources(machine);
        break;
        
      case 'make':
        await _makeCoffee(machine);
        break;
        
      case 'exit':
        print('\nРабота программы завершена');
        return;
        
      default:
        print('Неизвестная команда. Используйте: resources, add, make, exit');
    }
  }
}

Future<void> _fillResources(Machine machine) async {
  print('\nКакой ресурс добавить?');
  print('  1 - кофе');
  print('  2 - молоко');
  print('  3 - вода');
  
  stdout.write('Выберите (1-3): ');
  String choice = stdin.readLineSync() ?? '';
  
  String resourceType;
  switch (choice) {
    case '1':
      resourceType = 'coffeeBeans';
      break;
    case '2':
      resourceType = 'milk';
      break;
    case '3':
      resourceType = 'water';
      break;
    default:
      print('Неверный выбор');
      return;
  }
  
  stdout.write('Введите количество: ');
  int? amount = int.tryParse(stdin.readLineSync() ?? '');
  
  if (amount == null || amount <= 0) {
    print('Ошибка: введите корректное положительное число');
    return;
  }
  
  machine.fillResources(resourceType, amount);
  machine.showResources();
}

Future<void> _makeCoffee(Machine machine) async {
  print('\nВыберите вид кофе:');
  print('  1 - Эспрессо (50г кофе, 100мл воды) - 150 руб (без молока)');
  print('  2 - Капучино (30г кофе, 150мл молока, 100мл воды) - 200 руб (с молоком)');
  print('  3 - Латте (30г кофе, 200мл молока, 100мл воды) - 250 руб (с молоком)');
  print('  4 - Американо (40г кофе, 150мл воды) - 180 руб (без молока)');
  
  stdout.write('Выберите (1-4): ');
  String choice = stdin.readLineSync() ?? '';
  
  CoffeeType? type;
  switch (choice) {
    case '1':
      type = CoffeeType.espresso;
      break;
    case '2':
      type = CoffeeType.cappuccino;
      break;
    case '3':
      type = CoffeeType.latte;
      break;
    case '4':
      type = CoffeeType.americano;
      break;
    default:
      print('Неверный выбор');
      return;
  }
  
  await machine.makeCoffeeByType(type);
  machine.showResources();
}