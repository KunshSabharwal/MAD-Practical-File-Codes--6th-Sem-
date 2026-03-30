import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AuthApp());
}

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Auth App",
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFFD3D3FF),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? DashboardScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9400D3),
      body: Center(
        child: Text(
          "User Authentication",
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUser = prefs.getString("username");
    String? savedPass = prefs.getString("password");

    if (userController.text == savedUser && passController.text == savedPass) {
      await prefs.setBool("isLoggedIn", true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    }
  }

  Widget inputField(controller, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: label == "Password",
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFD8BFD8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9400D3), Color(0xFFED80E9)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Color(0xFF9400D3)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputField(userController, "Username"),
            inputField(passController, "Password"),
            SizedBox(height: 20),
            button("Login", login),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              child: Text("New user? Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  Future<void> register() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", userController.text);
    await prefs.setString("password", passController.text);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Registered Successfully")));

    Navigator.pop(context);
  }

  Widget inputField(controller, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: label == "Password",
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFD8BFD8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9400D3), Color(0xFFED80E9)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Color(0xFF9400D3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputField(userController, "Username"),
            inputField(passController, "Password"),
            SizedBox(height: 20),
            button("Register", register),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color(0xFF9400D3),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome! You are logged in 🎉",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
