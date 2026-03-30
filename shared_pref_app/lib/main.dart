import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyStorageApp());
}

class MyStorageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Data Storage",
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0xFFF28B82),
        scaffoldBackgroundColor: Color(0xFFFFF5F4),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF28B82),
      body: FadeTransition(
        opacity: animation,
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: Text(
              "Data Storage\nand Retrieval",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  Widget modernButton(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Ink(
          width: 280,
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC94C4C), Color(0xFFF28B82)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Storage",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF28B82),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            modernButton("Save New Record", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SaveScreen()),
              );
            }),
            modernButton("Retrieve Records", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RetrieveScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final rollController = TextEditingController();
  final nameController = TextEditingController();
  final projectController = TextEditingController();

  Future<void> saveRecord() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList("records") ?? [];

    Map<String, String> record = {
      "roll": rollController.text,
      "name": nameController.text,
      "project": projectController.text,
    };

    dataList.add(jsonEncode(record));
    await prefs.setStringList("records", dataList);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Record Saved")));

    rollController.clear();
    nameController.clear();
    projectController.clear();
  }

  Widget inputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFFFD5CF),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Record"),
        backgroundColor: Color(0xFFF28B82),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            inputField(rollController, "Roll Number"),
            inputField(nameController, "Student Name"),
            inputField(projectController, "Project Name"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRecord,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6E1E2B),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

class RetrieveScreen extends StatefulWidget {
  @override
  _RetrieveScreenState createState() => _RetrieveScreenState();
}

class _RetrieveScreenState extends State<RetrieveScreen> {
  String searchType = "roll";
  final searchController = TextEditingController();

  List<Map<String, dynamic>> results = [];

  Future<void> searchData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList("records") ?? [];

    List<Map<String, dynamic>> matches = [];

    for (var item in dataList) {
      Map<String, dynamic> decoded = jsonDecode(item);

      if (decoded[searchType].toLowerCase().contains(
        searchController.text.toLowerCase(),
      )) {
        matches.add(decoded);
      }
    }

    setState(() {
      results = matches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve Records"),
        backgroundColor: Color(0xFFF28B82),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: searchType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFD5CF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: [
                DropdownMenuItem(value: "roll", child: Text("Roll Number")),
                DropdownMenuItem(value: "name", child: Text("Name")),
                DropdownMenuItem(value: "project", child: Text("Project")),
              ],
              onChanged: (val) {
                setState(() {
                  searchType = val!;
                });
              },
            ),
            SizedBox(height: 12),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Enter search value",
                filled: true,
                fillColor: Color(0xFFFFD5CF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: searchData, child: Text("Search")),
            SizedBox(height: 20),

            Expanded(
              child: results.isEmpty
                  ? Center(child: Text("No Results Found"))
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, index) {
                        var item = results[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              item['name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Roll: ${item['roll']} | Project: ${item['project']}",
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
