void main() {}

class Square {
  double _side;

  Square({required double side})
    : assert(
        side > 0,
        ' compa aquí no se trabaja con números negativos o con el cero',
      ),
      _side = side;

  double get area => _side * _side;

  set side(double value) {
    if (value <= 0) {
      throw Exception('El lado debe ser mayor que cero');
    }
    _side = value;
  }
}
