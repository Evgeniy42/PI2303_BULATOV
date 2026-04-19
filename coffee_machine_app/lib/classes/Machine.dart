import 'Resources.dart';
import 'ICoffee.dart';
import 'CoffeeMaker.dart';
import '../enums/CoffeeTypes.dart';
import 'Coffee.dart';

class Machine {
  Resources resources;
  
  Machine({
    Resources? resources,
  }) : resources = resources ?? Resources();

  void fillResources(String resourceType, int amount) {
    switch (resourceType.toLowerCase()) {
      case 'coffeebeans':
        resources.coffeeBeans += amount;
        break;
      case 'milk':
        resources.milk += amount;
        break;
      case 'water':
        resources.water += amount;
        break;
      default:
        print('Неизвестный тип ресурса');
        return;
    }
  }
  
  // Метод для проверки ресурсов без приготовления
  Future<void> checkResources(CoffeeType type) async {
    ICoffee coffee;
    
    switch (type) {
      case CoffeeType.espresso:
        coffee = Espresso();
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        break;
      case CoffeeType.latte:
        coffee = Latte();
        break;
      case CoffeeType.americano:
        coffee = Americano();
        break;
    }
    
    if (!isAvailableResources(coffee)) {
      throw Exception('Недостаточно ресурсов!\nТребуется: ${coffee.coffeeBeans()}г кофе, ${coffee.milk()}мл молока, ${coffee.water()}мл воды');
    }
  }

  Future<void> makeCoffeeByType(CoffeeType type) async {
    ICoffee coffee;
    bool hasMilk;
    
    switch (type) {
      case CoffeeType.espresso:
        coffee = Espresso();
        hasMilk = false;
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        hasMilk = true;
        break;
      case CoffeeType.latte:
        coffee = Latte();
        hasMilk = true;
        break;
      case CoffeeType.americano:
        coffee = Americano();
        hasMilk = false;
        break;
    }
    
    await makeCoffee(coffee, hasMilk);
  }
  
  // Новый метод с прогрессом для GUI
  Future<void> makeCoffeeWithProgress(CoffeeType type, Function(String message) onProgress) async {
    ICoffee coffee;
    bool hasMilk;
    
    switch (type) {
      case CoffeeType.espresso:
        coffee = Espresso();
        hasMilk = false;
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        hasMilk = true;
        break;
      case CoffeeType.latte:
        coffee = Latte();
        hasMilk = true;
        break;
      case CoffeeType.americano:
        coffee = Americano();
        hasMilk = false;
        break;
    }
    
    await makeCoffeeWithProgressInternal(coffee, hasMilk, onProgress);
  }

  bool isAvailableResources(ICoffee coffee) {
    return resources.coffeeBeans >= coffee.coffeeBeans() &&
           resources.milk >= coffee.milk() &&
           resources.water >= coffee.water();
  }

  Future<void> makeCoffee(ICoffee coffee, bool hasMilk) async {
    if (isAvailableResources(coffee)) {
      // Асинхронное приготовление
      await CoffeeMaker.prepareCoffee(hasMilk, (message) {});
      
      // Списание ресурсов
      resources.coffeeBeans -= coffee.coffeeBeans();
      resources.milk -= coffee.milk();
      resources.water -= coffee.water();
      resources.cash += coffee.cash();
    } else {
      throw Exception('Недостаточно ресурсов');
    }
  }
  
  // Внутренний метод с прогрессом
  Future<void> makeCoffeeWithProgressInternal(ICoffee coffee, bool hasMilk, Function(String message) onProgress) async {
    if (isAvailableResources(coffee)) {
      // Асинхронное приготовление с прогрессом
      await CoffeeMaker.prepareCoffee(hasMilk, onProgress);
      
      // Списание ресурсов
      resources.coffeeBeans -= coffee.coffeeBeans();
      resources.milk -= coffee.milk();
      resources.water -= coffee.water();
      resources.cash += coffee.cash();
    } else {
      throw Exception('Недостаточно ресурсов для приготовления');
    }
  }
}