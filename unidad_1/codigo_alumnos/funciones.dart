void main() {
  // print(helloWorld());
  // print('Suma:${addTwoNumbers(25, 30)}');
  // print(acceptButton('Aceptar', onPressed: true));
  // print(acceptButton('Cancelar'));
  print(saludoPersonalizado());
  print(saludoPersonalizado(nombre: 'Jose Ramon'));
}

String helloWorld() {
  return "Hello World";
}

int addTwoNumbers(int a, int b) => a + b;

String acceptButton(String text, {bool onPressed = false}) =>
    onPressed ? 'Botón $text presionado' : 'Botón $text no presionado';

int sumTwoNumberOptional(int a, [int b = 0]) {
  return a + b;
}

String saludoPersonalizado({String? nombre}) {
  nombre ??= 'Invitado';
  return 'Hola $nombre';
}
