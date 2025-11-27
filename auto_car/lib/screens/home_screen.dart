import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/repositories/car_repository.dart';
import 'package:auto_car/widgets/car_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final CarRepository _carRepository = CarRepository();
  late Future<List<Car>> _carsFuture;
  
  String _selectedCategory = 'Tous';
  String _sortBy = 'Récents';
  final TextEditingController _searchController = TextEditingController();
  
  final List<String> categories = ['Tous', 'Sedan', 'SUV', 'Hatchback'];
  final List<String> sortOptions = ['Récents', 'Prix: bas→haut', 'Prix: haut→bas'];

  @override
  void initState() {
    super.initState();
    _carsFuture = _carRepository.getAllCars();
    _searchController.addListener(_onSearchChanged);
  }
    void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _carsFuture = _getFilteredCars();
      } else {
        _carsFuture = _carRepository.searchCars(_searchController.text);
      }
    });
  }
    Future<List<Car>> _getFilteredCars() async {
    List<Car> cars;
    
    if (_selectedCategory == 'Tous') {
      cars = await _carRepository.getAllCars();
    } else {
      cars = await _carRepository.filterByCategory(_selectedCategory);
    }
    // Appliquer le tri
    switch (_sortBy) {
      case 'Prix: bas→haut':
        cars = await _carRepository.sortByPrice(cars, ascending: true);
        break;
      case 'Prix: haut→bas':
        cars = await _carRepository.sortByPrice(cars, ascending: false);
        break;
      default:
        cars = await _carRepository.sortByYear(cars, ascending: false);
    }
    