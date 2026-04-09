import 'Resources.dart';
import 'ICoffee.dart';
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
    print('Добавлено $amount $resourceType');
  }

  void makeCoffeeByType(CoffeeType type) {
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
    
    makeCoffee(coffee);
  }

  bool isAvailableResources(ICoffee coffee) {
    return resources.coffeeBeans >= coffee.coffeeBeans() &&
           resources.milk >= coffee.milk() &&
           resources.water >= coffee.water();
  }

  void makeCoffee(ICoffee coffee) {
    if (isAvailableResources(coffee)) {
      resources.coffeeBeans -= coffee.coffeeBeans();
      resources.milk -= coffee.milk();
      resources.water -= coffee.water();
      resources.cash += coffee.cash();
      
      print('Кофе готов!');
      print('Списано: ${coffee.coffeeBeans()} гр кофе, ${coffee.milk()} мл молока, ${coffee.water()} мл воды');
      print('Добавлено: ${coffee.cash()} руб');
    } else {
      print('Недостаточно ресурсов!');
      print('Требуется:');
      print('  - Кофе: ${coffee.coffeeBeans()} гр (доступно: ${resources.coffeeBeans} гр)');
      print('  - Молоко: ${coffee.milk()} мл (доступно: ${resources.milk} мл)');
      print('  - Вода: ${coffee.water()} мл (доступно: ${resources.water} мл)');
    }
  }

  void showResources() {
    print('\n--- Текущие ресурсы машины ---');
    print('Кофе: ${resources.coffeeBeans} гр');
    print('Молоко: ${resources.milk} мл');
    print('Вода: ${resources.water} мл');
    print('Деньги: ${resources.cash} руб');
    print('--------------------------------');
  }
}