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
    return cars;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoCar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Recherche
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher une marque, modèle...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Filtres (Catégories)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == _selectedCategory;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                          _carsFuture = _getFilteredCars();
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

