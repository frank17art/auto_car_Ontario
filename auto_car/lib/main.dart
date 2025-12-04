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
<<<<<<< HEAD
        primaryColor: const Color.fromARGB(255, 30, 143, 5),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
=======
        primaryColor: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
>>>>>>> 60ba5c58994fd6f6b825817beced898338b6c5f1
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
<<<<<<< HEAD
        return MaterialPageRoute(builder: (context) => ContactScreen(car: car));

      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
=======
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
>>>>>>> 60ba5c58994fd6f6b825817beced898338b6c5f1
