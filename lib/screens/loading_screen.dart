import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;
  String apiKey = '28df77a834ac1db39c7fc1970930f96c';

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();







    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );

    double temperature = weatherData['main']['temp'];
    int idCondition = weatherData['weather'][0]['id'];
    String cityName = weatherData['name'];
    print(temperature);
    print(idCondition);

    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.indigoAccent,
        ),
      ),
    );
  }
}
