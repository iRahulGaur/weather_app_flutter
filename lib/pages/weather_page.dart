import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_flutter/constants_values.dart';
import 'package:weather_app_flutter/models/weather_model.dart';
import 'package:weather_app_flutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService(ConstantsValues.getAPIKey());
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current lat long
    String latlon = await _weatherService.getCurrentCity();
    List<String> locations = latlon.split(" + ");

    //get weather
    try {
      final weather =
          await _weatherService.getWeather(locations[0], locations[1]);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }

    print('this is weather = $_weather');
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on start
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _weather?.cityName ?? "Loading",
          style: const TextStyle(fontSize: 20),
        ),
        // Lottie.asset('assets/rain.json'),
        Text(
          "${_weather?.temperature.round()}°C",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          _weather?.mainCondition ?? "",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
