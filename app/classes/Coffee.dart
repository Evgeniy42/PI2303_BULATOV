import 'ICoffee.dart';

// Эспрессо
class Espresso implements ICoffee {
  @override
  int coffeeBeans() => 50;
  
  @override
  int milk() => 0;
  
  @override
  int water() => 100;
  
  @override
  double cash() => 150.0;
}

// Капучино
class Cappuccino implements ICoffee {
  @override
  int coffeeBeans() => 30;
  
  @override
  int milk() => 150;
  
  @override
  int water() => 100;
  
  @override
  double cash() => 200.0;
}

// Латте
class Latte implements ICoffee {
  @override
  int coffeeBeans() => 30;
  
  @override
  int milk() => 200;
  
  @override
  int water() => 100;
  
  @override
  double cash() => 250.0;
}

// Американо
class Americano implements ICoffee {
  @override
  int coffeeBeans() => 40;
  
  @override
  int milk() => 0;
  
  @override
  int water() => 150;
  
  @override
  double cash() => 180.0;
}