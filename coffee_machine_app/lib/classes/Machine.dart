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
    print('Добавлено $amount $resourceType');
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

  bool isAvailableResources(ICoffee coffee) {
    return resources.coffeeBeans >= coffee.coffeeBeans() &&
           resources.milk >= coffee.milk() &&
           resources.water >= coffee.water();
  }

  Future<void> makeCoffee(ICoffee coffee, bool hasMilk) async {
    if (isAvailableResources(coffee)) {
      print('\nРесурсы для приготовления:');
      print('  - Кофе: ${coffee.coffeeBeans()} гр');
      print('  - Молоко: ${coffee.milk()} мл');
      print('  - Вода: ${coffee.water()} мл');
      print('  - Стоимость: ${coffee.cash()} руб');
      
      await CoffeeMaker.prepareCoffee(hasMilk);
      
      resources.coffeeBeans -= coffee.coffeeBeans();
      resources.milk -= coffee.milk();
      resources.water -= coffee.water();
      resources.cash += coffee.cash();
      
      print('С вашего счета списано: ${coffee.cash()} руб\n');
    } else {
      print('\nНедостаточно ресурсов!');
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