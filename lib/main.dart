import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Iphone',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget { //class calculator adalah widget stateful karna memiliki nilai yang selalu berubah ketika tombolnya di tekan
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0'; // output merupakan variabel yang menampung nilai yang akan ditampilkan di kalkulator

  void buttonPressed(String buttonText) { // fungsi buttonPressed yang akan dipanggil ketika tombol di tekan
    setState(() {

    if (buttonText == "C") { // jika tombol C ditekan, OUTPIT DIUBAH MENJADI 0
  output = "0";
    } 
    else if (buttonText == "="){ // jika tombol = ditekan, output diubah menjadi hasil dari expression 
    try{
      output = evaluateExpression(
        output.replaceAll('x', '*'));
  } catch (e) { 
    output = "Error"; // jika terjadi kesalahan, output yang muncul di kalkulator diubah menjadi error
  }
    } else {
      if (output == "0") {
        output = buttonText;
      } else {
        output += buttonText;
      }
    }
  });
 }
 
String evaluateExpression(String expression) {
  final parsedExpression = Expression.parse(expression);
  final evaulator = ExpressionEvaluator();
  final result = evaulator.eval(parsedExpression, {});
  return result.toString();
}

Widget buildButton(String buttonText, Color color, {double
widthFactor = 1.0}) { // fungsi ini digunakan untuk membuat widget tombol dengan text, warna, dan ukuran yang sudah ditentukan
return Expanded(
flex: widthFactor.toInt(), // widhtfactor digunakan untuk menentukan lebar tombol menjadi 1. flex digunaakn untuk menentukan proporsi lebar tombol dalam baris
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton( // digunakan untuk membuat tombol denga gaya tertentu
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 22), // digunakan untuk mengatur jarak dalam tombol secara virtical menjadi 22 sehingga tombol terlihat tinggi
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0), // digunakan untuk membuat sudut tombol melengkung dengan radius 40
         ),
         elevation: 0, // mengatur bayangan tombol menjadi 0 dan tampak datar
        ),
        onPressed: () => buttonPressed(buttonText), // ketika ditekan, fungsi buttonPressed dipanggil dengan parameter buttonText
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
} 

@override
  Widget build(BuildContext context) { // fungsi build digunakan untuk membuat tampilan utama
  return Scaffold( // digunakan untuk membuat struktur dasar untuk halaman
  body: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget> [
      Expanded(
        child: Container(
          padding: EdgeInsets.only(right: 24, bottom: 24),
          alignment: Alignment.bottomRight,
          child: Text(
            output,
            style: TextStyle(fontSize: 80, color: Colors.white),
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildButton("C", Colors.grey.shade600),
              buildButton("+/-", Colors.grey.shade600),
              buildButton("%", Colors.grey.shade600),
              buildButton("/", Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("7", Colors.grey.shade600),
              buildButton("8", Colors.grey.shade600),
              buildButton("9", Colors.grey.shade600),
              buildButton("x", Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("4", Colors.grey.shade600),
              buildButton("5", Colors.grey.shade600),
              buildButton("6", Colors.grey.shade600),
              buildButton("-", Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1", Colors.grey.shade600),
              buildButton("2", Colors.grey.shade600),
              buildButton("3", Colors.grey.shade600),
              buildButton("+", Colors.orange),
            ],
          ),
          Row(
           children: <Widget> [
            buildButton("0", Colors.grey.shade800, widthFactor:2),
            buildButton(".", Colors.grey.shade800),
            buildButton("=", Colors.orange),
           ],
          ),
          ],
      ),
    ],
  ),
);
 }
  }
