void main() {
  final Map<String, dynamic> persona = {
    'nombre': 'jose Ramon Bogarin',
    'edad': 34,
    'trabajando': true,
    'habilidades': ['Flutter', 'Dart', 'JavaScript'],
    'redes_sociales': ['Facebook', 'Twitter', 'Instagram'],
  };

  print(persona);
  print(
    'La persona se llama ${persona['nombre']} y tiene ${persona['edad']} años.',
  );
  print('¿La persona está trabajando? ${persona['trabajando'] ? "Sí" : "No"}');

  print('Mis habilidades son: ${persona['habilidades'].join(", ")}');
  print('Pero La que mas Me gusta es: ${persona['habilidades'][2]}');
}
