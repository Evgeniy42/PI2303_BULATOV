import 'dart:io';
import 'classes/Machine.dart';

void main() {
  Machine machine = Machine(
    coffeeBeans: 100,
    milk: 200,
    water: 300,
    cash: 0,
  );

  print('Доступные команды:');
  print('add - добавить ресурс');
  print('coffee - приготовить кофе');
  print('exit - выход');

  while (true) {
    stdout.write('\nВведите команду: ');
    String command = stdin.readLineSync()?.toLowerCase() ?? '';

    switch (command) {
      case 'add':
        _addResource(machine);
        break;
        
      case 'coffee':
        _makeCoffee(machine);
        break;
        
      case 'exit':
        print('Работа программы завершена');
        return;
        
      default:
        print('Неизвестная команда. Доступные команды: add, coffee, exit');
    }
  }
}

void _addResource(Machine machine) {
  print('\nКакой ресурс добавить?');
  print('coffeeBeans - кофе');
  print('milk - молоко');
  print('water - вода');
  
  stdout.write('Выберите ресурс: ');
  String resource = stdin.readLineSync()?.toLowerCase() ?? '';
  
  stdout.write('Введите количество: ');
  int? amount = int.tryParse(stdin.readLineSync() ?? '');
  
  if (amount == null || amount <= 0) {
    print('Ошибка: введите корректное положительное число');
    return;
  }
  
  switch (resource) {
    case 'coffeebeans':
      machine.coffeeBeans += amount;
      print('Добавлено $amount кофе');
      break;
    case 'milk':
      machine.milk += amount;
      print('Добавлено $amount молока');
      break;
    case 'water':
      machine.water += amount;
      print('Добавлено $amount воды');
      break;
    default:
      print('Неизвестный ресурс');
  }
  
  _showResources(machine);
}

void _makeCoffee(Machine machine) {
  print('\nПроверка ресурсов для эспрессо...');
  
  if (machine.isAvailableResources()) {
    print('Ресурсов достаточно');
    machine.makingCoffee();
    print('Кофе готов!');
    print('С машины списано: 50 гр кофе, 100 мл воды');
    print('В машину добавлено: 150 руб');
  } else {
    print('Недостаточно ресурсов для приготовления кофе');
    print('Требуется: 50 гр кофе, 100 мл воды');
  }
  
  _showResources(machine);
}

void _showResources(Machine machine) {
  print('\n--- Текущие ресурсы машины ---');
  print('Кофе: ${machine.coffeeBeans} гр');
  print('Молоко: ${machine.milk} мл');
  print('Вода: ${machine.water} мл');
  print('Деньги: ${machine.cash} руб');
  print('-------------------------------');
}