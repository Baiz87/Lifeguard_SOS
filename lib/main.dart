import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const LifeGuardApp());
}

class LifeGuardApp extends StatelessWidget {
  const LifeGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SOSHomePage(),
    );
  }
}

class SOSHomePage extends StatefulWidget {
  const SOSHomePage({super.key});

  @override
  State<SOSHomePage> createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    
    if (permission == LocationPermission.deniedForever) {
      return;
    }flutter create .

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        
    print("Lat: ${position.latitude}, Lng: ${position.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeGuard SOS - فریاگوزاری خێرا'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'بۆ حاڵەتی لە ناکاو دوگمەی خوارەوە بگرە',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(40),
                ),
                child: const Text(
                  'SOS',
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}