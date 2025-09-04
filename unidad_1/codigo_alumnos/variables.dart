void main() {
  String nombre = 'jose Ramon Bogarin';
  int edad = 34;
  print('La persona se llama ${nombre.toUpperCase()} y tiene $edad años.');
  bool work = true;
  print('¿La persona está trabajando? ${work ? "Sí" : "No"}');
  List<String> habilidades = ['Flutter', 'Dart', 'JavaScript'];
  print('Habilidades de la persona: ${habilidades.join(", ")}');
  final redes_sociales = <String>['Facebook', 'Twitter', 'Instagram'];
  print('Redes sociales de la persona: ${redes_sociales.join(", ")}');
  redes_sociales.add('LinkedIn');
  print(
    'Redes sociales de la persona después de agregar una nueva: ${redes_sociales.join(", ")}',
  );
  final int years = 24;
  print('La persona tiene $years años de experiencia.');
  years = 24;
}
