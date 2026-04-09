import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(SensorApp());
}

class SensorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motion Tracker',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SensorHome(),
    );
  }
}

class SensorHome extends StatefulWidget {
  @override
  _SensorHomeState createState() => _SensorHomeState();
}

class _SensorHomeState extends State<SensorHome> {
  String accelerometerData = "Waiting...";
  String gyroscopeData = "Waiting...";
  String locationData = "Not fetched";

  @override
  void initState() {
    super.initState();
    startSensors();
  }

  void startSensors() {
    accelerometerEventStream().listen((event) {
      setState(() {
        accelerometerData =
            "X: ${event.x.toStringAsFixed(2)} | Y: ${event.y.toStringAsFixed(2)} | Z: ${event.z.toStringAsFixed(2)}";
      });
    });

    gyroscopeEventStream().listen((event) {
      setState(() {
        gyroscopeData =
            "X: ${event.x.toStringAsFixed(2)} | Y: ${event.y.toStringAsFixed(2)} | Z: ${event.z.toStringAsFixed(2)}";
      });
    });
  }

  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => locationData = "Enable location services");
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      locationData =
          "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";
    });
  }

  Widget buildCard(String title, String data, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 30),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Motion Tracker"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildCard("Accelerometer", accelerometerData, Icons.phone_android),
            buildCard("Gyroscope", gyroscopeData, Icons.screen_rotation),
            buildCard("Location", locationData, Icons.location_on),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: getLocation,
              icon: Icon(Icons.my_location),
              label: Text("Get Location"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
