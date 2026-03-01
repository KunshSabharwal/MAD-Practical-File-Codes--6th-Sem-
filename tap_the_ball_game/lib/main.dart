import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

//////////////////////////////////////////////////////////////
// COLORS
//////////////////////////////////////////////////////////////

class AppColors {
  static const blush = Color(0xFFF2C7C7);
  static const mint = Color(0xFFD5F3D8);
  static const pink = Color(0xFFFFB7C5);
  static const white = Colors.white;
  static const text = Color(0xFF444444);
}

//////////////////////////////////////////////////////////////
// MAIN
//////////////////////////////////////////////////////////////

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TapBallApp());
}

class TapBallApp extends StatelessWidget {
  const TapBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const SplashScreen(),
    );
  }
}

//////////////////////////////////////////////////////////////
// SPLASH SCREEN
//////////////////////////////////////////////////////////////

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.blush, AppColors.pink]),
        ),
        child: Center(
          child: FadeTransition(
            opacity: controller,
            child: const Text(
              "Tap The Ball",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// HOME SCREEN (FIXED CENTERING)
//////////////////////////////////////////////////////////////

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget button(BuildContext c, String text, Color color, Widget screen) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () =>
            Navigator.push(c, MaterialPageRoute(builder: (_) => screen)),
        child: Text(text, style: const TextStyle(color: AppColors.text)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mint,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              "Tap The Ball",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                "How to Play:\nTap the moving ball as fast as you can.\nEach tap = +1 score.\nYou have 30 seconds!",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    button(
                      context,
                      "Start New Game",
                      AppColors.pink,
                      const GameScreen(),
                    ),
                    const SizedBox(height: 15),
                    button(
                      context,
                      "Game History",
                      AppColors.blush,
                      const HistoryScreen(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// GAME SCREEN (FULL RESPONSIVE PLAY AREA)
//////////////////////////////////////////////////////////////

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final random = Random();

  double x = 50, y = 50;
  int score = 0, timeLeft = 30;
  Timer? timer;
  bool gameOver = false;

  static const double ball = 60;

  @override
  void initState() {
    super.initState();
    start();
  }

  ////////////////////////////////////////////////////////////
  // TIMER
  ////////////////////////////////////////////////////////////

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          t.cancel();
          endGame();
        }
      });
    });
  }

  ////////////////////////////////////////////////////////////
  // MOVE BALL (RESPONSIVE)
  ////////////////////////////////////////////////////////////

  void move(double width, double height) {
    x = random.nextDouble() * (width - ball);
    y = random.nextDouble() * (height - ball);
  }

  ////////////////////////////////////////////////////////////
  // END GAME
  ////////////////////////////////////////////////////////////

  Future<void> endGame() async {
    gameOver = true;

    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("scores") ?? [];
    list.add(score.toString());
    await prefs.setStringList("scores", list);

    if (!mounted) return;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Time's Up!"),
        content: Text("Your Score: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Back Home"),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // UI
  ////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Score: $score   Time: $timeLeft",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final boxWidth = constraints.maxWidth;
                    final boxHeight = constraints.maxHeight;

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.mint,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            left: x.clamp(0, boxWidth - ball),
                            top: y.clamp(0, boxHeight - ball),
                            child: GestureDetector(
                              onTap: gameOver
                                  ? null
                                  : () {
                                      setState(() {
                                        score++;
                                        move(boxWidth, boxHeight);
                                      });
                                    },
                              child: Container(
                                width: ball,
                                height: ball,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.blush,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

//////////////////////////////////////////////////////////////
// HISTORY SCREEN
//////////////////////////////////////////////////////////////

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<int> scores = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("scores") ?? [];
    setState(() => scores = list.map(int.parse).toList());
  }

  @override
  Widget build(BuildContext context) {
    int high = scores.isEmpty ? 0 : scores.reduce(max);

    return Scaffold(
      backgroundColor: AppColors.blush,
      appBar: AppBar(
        backgroundColor: AppColors.pink,
        title: const Text("Game History"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "High Score: $high",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: scores.length,
              itemBuilder: (_, i) => ListTile(
                title: Text("Game ${i + 1}"),
                trailing: Text("${scores[i]}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
