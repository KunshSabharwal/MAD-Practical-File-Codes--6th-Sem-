import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MultimediaApp());
}

class MultimediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Capture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MultimediaHome(),
    );
  }
}

class MultimediaHome extends StatefulWidget {
  @override
  _MultimediaHomeState createState() => _MultimediaHomeState();
}

class _MultimediaHomeState extends State<MultimediaHome> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setVolume(1.0);
  }

  Future<void> captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // 🔊 Auto shutter sound
      await _audioPlayer.play(AssetSource('audio/sample.mp3'));
    }
  }

  Future<void> playAudio() async {
    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.play(AssetSource('audio/sample.mp3'));
  }

  Widget buildPreview() {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(_image!, fit: BoxFit.cover),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, size: 50, color: Colors.grey[600]),
                SizedBox(height: 10),
                Text(
                  "No Image Captured",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
    );
  }

  Widget buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Capture"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildPreview(),

            SizedBox(height: 25),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      "Camera Controls",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),

                    buildButton("Capture Image", Icons.camera, captureImage),

                    SizedBox(height: 10),

                    buildButton("Play Sound", Icons.volume_up, playAudio),
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
