void main() {
  final List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    5,
    5,
    6,
    7,
    8,
    9,
    8,
    9,
    10,
    11,
    10,
    11,
    10,
  ];

  print('lista original: $numbers');

  print('lenth: ${numbers.length}');
  print('isEmpty: ${numbers.isEmpty}');
  print('isNotEmpty: ${numbers.isNotEmpty}');
  print('first: ${numbers.first}');
  print('last: ${numbers.last}');
  print('reversed: ${numbers.reversed.toList()}');
  print('unicos: ${numbers.toSet()}');
  print('unicos: ${numbers.toSet().toList()}');

  final numbersGreaterThan5 = numbers
      .where((int number) => number > 5)
      .toList()
      .toSet()
      .toList();
  print('números maiores que 5: ${numbersGreaterThan5}');
}
