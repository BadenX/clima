import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  Future<void> getLocation() async {
    Location location = Location();
    try {
      await location.getCurrentLocation();
    } catch (e) {
      print("ERROR IN GETLOCATION: $e");
    }
  }

  Future<void> getData() async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={API KEY}',
    );

    Response response = await get(url);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
