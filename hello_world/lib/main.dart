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
            // Icon 1
            IconButton(
              icon: const Icon(Icons.thumb_up),
              iconSize: 40,
              color: const Color.fromARGB(255, 0, 71, 2),
              onPressed: () {
                debugPrint('Thumb up icon pressed');
              },
            ),

            const SizedBox(height: 20),

            // Icon 2
            IconButton(
              icon: const Icon(Icons.info),
              iconSize: 40,
              color: const Color.fromARGB(255, 0, 71, 2),
              onPressed: () {
                debugPrint('Info icon pressed');
              },
            ),

            const SizedBox(height: 20),

            // Icon 3
            IconButton(
              icon: const Icon(Icons.send),
              iconSize: 40,
              color: const Color.fromARGB(255, 0, 71, 2),
              onPressed: () {
                debugPrint('Send icon pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
