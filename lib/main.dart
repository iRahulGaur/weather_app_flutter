import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/pages/permissions_page.dart';
import 'package:weather_app_flutter/providers/location_provider.dart';
import 'package:weather_app_flutter/providers/weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                WeatherProvider(apiKey: 'dummyAPI')),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PermissionsPage(),
    );
  }
}
