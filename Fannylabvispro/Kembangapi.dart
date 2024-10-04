import 'dart:io';
import 'dart:async';
import 'Warna.dart' as color;

final Map<String, List<String>> fireworkFrame = {
  '1': [
    // Frame 1: Meluncur awal
    '                ',
    '                ',
    '      ***       ',
    '      ***       ',
    '                ',
    '                ',
  ],
  '2': [
    // Frame 2: Kembang api muncul
    '               ',
    '               ',
    '               ',
    '       *       ',
    '      * *      ',
    '     * * *     ',
    '      * *      ',
    '       *       ',
  ],
  '3': [
    // Frame 3: Kembang api meledak
    '                ',
    '       *        ',
    '     * * *      ',
    '   * * * * *    ',
    '     * * *      ',
    '       *        ',
  ],
  '4': [
    // Frame 4: Ledakan penuh (kucing)
    '      /\\_/\\      ',
    '     ( o  o  )     ',
    '     (  =^=  )    ',
    '      \\~(*)~/     ',
    '      /     \\      ',
  ],
  '5': [
    // Frame 5: Ekspansi ledakan
    '                 ',
    '   * * * * * *   ',
    ' * * * * * * * * ',
    '   * * * * * *   ',
    '                 ',
  ],
  '6': [
    // Frame 6: Ledakan memudar
    '                 ',
    '                 ',
    '      * * *      ',
    '                 ',
    '                 ',
  ],
};

void moveTo(int row, int col) {
  stdout.write('\x1B[${row};${col}H');
}

void printFireworkFrame(
    String frameKey, int centerX, int centerY, List<String> colorSelects) {
  List<String> frame = fireworkFrame[frameKey] ?? [];
  String bgColor =
      color.getBackgroundColor(colorSelects[1]); // Ambil warna latar belakang
  String fontColor = color.BLACK; // Set warna kembang api menjadi hitam

  for (var i = 0; i < frame.length; i++) {
    moveTo(centerY - (frame.length ~/ 2) + i, centerX - (frame[i].length ~/ 2));
    String line = frame[i];
    for (var char in line.split('')) {
      if (char == ' ') {
        stdout.write(bgColor +
            ' ' +
            color.RESET); // Gunakan warna latar belakang untuk spasi
      } else {
        stdout.write(
            fontColor + char + color.RESET); // Gunakan warna untuk karakter
      }
    }
  }
}

void clearScreen() {
  stdout.write('\x1B[2J\x1B[0;0H');
}

void changeBackground(String colorSelect) {
  print(color.getBackgroundColor(colorSelect));
  clearScreen();
}

// Function to hide cursor
void hideCursor() {
  stdout.write('\x1B[?25l');
}

// Function to show cursor
void showCursor() {
  stdout.write('\x1B[?25h');
}

// Define the delay function
Future<void> delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

Future<void> kembangApi(
    int centerX, int centerY, List<String> colorSelects) async {
  String fontColor = colorSelects[1];

  hideCursor(); // Hide cursor at the beginning

  // Frame 1: Meluncur ke atas
  for (int i = 1; i <= 5; i++) {
    changeBackground(fontColor);
    clearScreen();
    printFireworkFrame(
        '1', centerX, centerY - i, colorSelects); // Pindah ke atas
    await delay(100); // Delay untuk efek peluncuran
  }

  // Frame 2: Kembang api muncul
  String bgColor =
      color.getBackgroundColor(fontColor); // Simpan warna latar belakang
  changeBackground(fontColor); // Set warna latar belakang
  clearScreen();
  printFireworkFrame('2', centerX, centerY, colorSelects);
  await delay(300); // Delay sebelum meledak

  // Frame 3: Kembang api meledak
  changeBackground(bgColor); // Tetap menggunakan warna latar belakang yang sama
  clearScreen();
  printFireworkFrame('3', centerX, centerY, colorSelects);
  await delay(100); // Delay untuk efek ledakan

  // Frame 4: Ledakan penuh (kucing)
  changeBackground(bgColor);
  clearScreen();
  printFireworkFrame('4', centerX, centerY, colorSelects);
  await delay(100); // Delay untuk efek ledakan penuh

  // Frame 5: Ekspansi ledakan
  changeBackground(bgColor);
  clearScreen();
  printFireworkFrame('5', centerX, centerY, colorSelects);
  await delay(100); // Delay untuk efek ekspansi

  // Frame 6: Ledakan memudar
  changeBackground(bgColor);
  clearScreen();
  printFireworkFrame('6', centerX, centerY, colorSelects);
  await delay(100); // Delay untuk menampilkan efek memudar

  showCursor(); // Show cursor at the end
}

void main() async {
  int centerX = 40; // Posisi horizontal kembang api
  int centerY = 20; // Posisi vertical kembang api
  List<String> colorSelects = [color.BLACK, color.YELLOW]; // Pilihan warna

  await kembangApi(centerX, centerY, colorSelects);
}
