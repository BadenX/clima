import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiKey = dotenv.env['OPEN_WEATHER_API_KEY']!;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    double latitude = location.latitude ?? 52.3676;
    double longitude = location.longitude ?? 4.9041;

    print('LAT: $latitude');
    print('LON: $longitude');

    await getData(latitude, longitude);
  }

  Future<void> getData(double latitude, double longitude) async {
    print('GET DATA START');

    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    );

    http.Response response = await http.get(url);

    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');

    var decodedData = jsonDecode(response.body);

    double temperature = decodedData['main']['temp'];
    int condition = decodedData['weather'][0]['id'];
    String cityName = decodedData['name'];

    print(temperature);
    print(condition);
    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Loading...')));
  }
}
