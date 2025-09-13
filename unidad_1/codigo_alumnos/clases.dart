void main() {
  final Hero wollwerine = Hero(name: 'Logan');
  print(wollwerine.name);
  print(wollwerine.power);
}

class Hero {
  String name;
  String power;

  Hero({required this.name, this.power = 'no tiene poder'});
}
