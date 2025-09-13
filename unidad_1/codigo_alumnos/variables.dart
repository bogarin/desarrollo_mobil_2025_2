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

  dynamic mensaje = "hola";
  mensaje = 123;

  print(mensaje);
  var mensaje2 = "hola2";

  final errorMensaje = false;
  late String mensaje3;
  mensaje3 = "cosas raras";
  print(mensaje3);
  print('¿Hay un mensaje de error? ${errorMensaje ? "Sí" : "No"}');

  String holamundo() => "mensaje raro";
  String holamundo2() {
    return "mensaje raro 2";
  }

  print(holamundo());
  print(holamundo2());

  print("""
La persona tiene $years años de experiencia.



La persona se llama ${nombre.toUpperCase()} y tiene $edad años.
Redes sociales de la persona: ${redes_sociales.join(", ")}      
""");
}
