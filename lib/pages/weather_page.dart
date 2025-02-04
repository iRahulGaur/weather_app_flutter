import 'package:flutter/material.dart';
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

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on start
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //city name
          Text(_weather?.cityName ?? "loading city.."),
          //temp
          Text('${_weather?.temperature.round() ?? 0}*C'),
        ],
      ),
    );
  }
}
