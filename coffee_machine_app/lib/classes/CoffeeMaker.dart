import 'dart:async';

class CoffeeMaker {

  Future<void> heatWater() async {
    print('Начинаем нагрев воды...');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета до 95°C');
  }
  
  Future<void> brewCoffee() async {
    print('Завариваем кофе...');
    await Future.delayed(Duration(seconds: 5));
    print('Кофе заварен');
  }
  
  Future<void> frothMilk() async {
    print('Взбиваем молоко...');
    await Future.delayed(Duration(seconds: 5));
    print('Молоко взбито');
  }
  
  Future<void> mixCoffeeAndMilk() async {
    print('Смешиваем кофе с молоком...');
    await Future.delayed(Duration(seconds: 3));
    print('Напиток смешан');
  }
  
  Future<void> makeCoffeeWithoutMilk() async {
    print('\n=== Начинаем приготовление кофе без молока ===');
    
    await heatWater();
    
    await brewCoffee();
    
    print('\nКофе готов! Приятного аппетита!\n');
  }
  
  Future<void> makeCoffeeWithMilk() async {
    print('\n=== Начинаем приготовление кофе с молоком ===');
    
    await heatWater();

    await Future.wait([
      brewCoffee(),
      frothMilk(),
    ]);
    
    await mixCoffeeAndMilk();
    
    print('\nКофе с молоком готов! Приятного аппетита!\n');
  }
  
  static Future<void> prepareCoffee(bool hasMilk) async {
    final coffeeMaker = CoffeeMaker();
    
    if (hasMilk) {
      await coffeeMaker.makeCoffeeWithMilk();
    } else {
      await coffeeMaker.makeCoffeeWithoutMilk();
    }
  }
}