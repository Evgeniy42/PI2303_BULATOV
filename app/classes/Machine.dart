class Machine {

  int _coffeeBeans = 0;
  int _milk = 0;
  int _water = 0;
  double _cash = 0.0;

  Machine({
    int coffeeBeans = 0,
    int milk = 0,
    int water = 0,
    double cash = 0.0,
  }) {
    _coffeeBeans = coffeeBeans;
    _milk = milk;
    _water = water;
    _cash = cash;
  }

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  double get cash => _cash;

  set coffeeBeans(int value) {
    if (value >= 0) {
      _coffeeBeans = value;
    }
  }

  set milk(int value) {
    if (value >= 0) {
      _milk = value;
    }
  }

  set water(int value) {
    if (value >= 0) {
      _water = value;
    }
  }

  set cash(double value) {
    if (value >= 0) {
      _cash = value;
    }
  }

}