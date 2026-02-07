import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 132, 9),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/image.jpg', height: 400, width: 400),
            SizedBox(height: 200),
            Text(
              'Random Nature Image',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 48, 6),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
