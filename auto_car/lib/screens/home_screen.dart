import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/repositories/car_repository.dart';
import 'package:auto_car/widgets/car_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
