import 'dart:async';

class CoffeeMaker {
  
  // Callback для отправки сообщений в GUI
  final Function(String message)? onProgress;
  
  CoffeeMaker({this.onProgress});
  
  // Метод для нагрева воды (задержка 3 секунды)
  Future<void> heatWater() async {
    onProgress?.call('Начинаем нагрев воды...');
    await Future.delayed(const Duration(seconds: 3));
    onProgress?.call('Вода нагрета до 95°C');
  }
  
  // Метод для заваривания кофе (после нагрева воды, задержка 5 секунд)
  Future<void> brewCoffee() async {
    onProgress?.call('Завариваем кофе...');
    await Future.delayed(const Duration(seconds: 5));
    onProgress?.call('Кофе заварен');
  }
  
  // Метод для взбивания молока (запускается вместе с завариванием кофе, задержка 5 секунд)
  Future<void> frothMilk() async {
    onProgress?.call('Взбиваем молоко...');
    await Future.delayed(const Duration(seconds: 5));
    onProgress?.call('Молоко взбито');
  }
  
  // Метод для смешивания кофе и молока (после приготовления кофе и молока, задержка 3 секунды)
  Future<void> mixCoffeeAndMilk() async {
    onProgress?.call('Смешиваем кофе с молоком...');
    await Future.delayed(const Duration(seconds: 3));
    onProgress?.call('Напиток смешан');
  }
  
  // Асинхронный метод для приготовления кофе без молока (эспрессо, американо)
  Future<void> makeCoffeeWithoutMilk() async {
    onProgress?.call('\n=== Начинаем приготовление кофе без молока ===');
    
    // Нагрев воды
    await heatWater();
    
    // Заваривание кофе
    await brewCoffee();
    
    onProgress?.call('Кофе готов! Приятного аппетита!');
  }
  
  // Асинхронный метод для приготовления кофе с молоком (капучино, латте)
  Future<void> makeCoffeeWithMilk() async {
    onProgress?.call('=== Начинаем приготовление кофе с молоком ===');
    
    // Нагрев воды
    await heatWater();
    
    // Заваривание кофе и взбивание молока параллельно
    await Future.wait([
      brewCoffee(),
      frothMilk(),
    ]);
    
    // Смешивание кофе и молока
    await mixCoffeeAndMilk();
    
    onProgress?.call('Кофе с молоком готов! Приятного аппетита!');
  }
  
  // Фабричный метод для создания кофе с асинхронным приготовлением
  static Future<void> prepareCoffee(bool hasMilk, Function(String message) onProgress) async {
    final coffeeMaker = CoffeeMaker(onProgress: onProgress);
    
    if (hasMilk) {
      await coffeeMaker.makeCoffeeWithMilk();
    } else {
      await coffeeMaker.makeCoffeeWithoutMilk();
    }
  }
}