void main() {
  final Map<String, dynamic> rawJson = {
    'name': 'Logan',
    'power': 'regeneracion',
    'isAlive': false,
  };

  final Hero wollwerine = Hero.fromJson(rawJson);
  print(wollwerine.toString());
}

class Hero {
  String name;
  String power;
  bool isAlive;

  Hero({required this.name, required this.power, required this.isAlive});

  Hero.fromJson(Map<String, dynamic> json)
    : name = json['name'] ?? 'no name',
      power = json['power'] ?? 'no power',
      isAlive = json['isAlive'] ?? true;

  @override
  String toString() {
    return 'Hero: name: $name, power: $power, isAlive: $isAlive';
  }
}
