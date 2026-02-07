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
      backgroundColor: const Color.fromARGB(255, 23, 252, 130),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Elevated Button
            ElevatedButton(
              onPressed: () {
                debugPrint('Elevated Button Pressed');
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 63, 170, 6),
                ),
              ),
              child: const Text('Elevated Button'),
            ),

            const SizedBox(height: 15),

            // Text Button
            TextButton(
              onPressed: () {
                debugPrint('Text Button Pressed');
              },
              child: const Text(
                'Text Button',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 2)),
              ),
            ),

            const SizedBox(height: 15),

            // Outlined Button
            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined Button Pressed');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(255, 0, 71, 2)),
              ),
              child: const Text(
                'Outlined Button',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
