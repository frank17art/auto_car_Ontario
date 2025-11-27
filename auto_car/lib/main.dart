import 'package:flutter/material.dart';
import 'package:auto_car/screens/home_screen.dart';
import 'package:auto_car/screens/car_detail_screen.dart';
import 'package:auto_car/screens/contact_screen.dart';
import 'package:auto_car/models/car.dart';

void main() {
  runApp(const AutoCarApp());
}

class AutoCarApp extends StatelessWidget {
  const AutoCarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoCar',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
      onGenerateRoute: _generateRoute,
    );
  }

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/car-detail':
        final carId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CarDetailScreen(carId: carId),
        );

      case '/contact':
        final car = settings.arguments as Car;
        return MaterialPageRoute(
          builder: (context) => ContactScreen(car: car),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}