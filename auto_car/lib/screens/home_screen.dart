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
          // Tri
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trier par:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: _sortBy,
                  items: sortOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value!;
                      _carsFuture = _getFilteredCars();
                    });
                  },
                ),
              ],
            ),
          ),
          // Grille des voitures
          Expanded(
            child: FutureBuilder<List<Car>>(
              future: _carsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur: ${snapshot.error}'),
                  );
                }

                final cars = snapshot.data ?? [];

                if (cars.isEmpty) {
                  return const Center(
                    child: Text('Aucune voiture trouvée'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    
                    return CarCard(
                      car: car,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/car-detail',
                          arguments: car.id,
                        );
                      },
                      onFavoriteTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${car.brand} ${car.model} ajouté aux favoris',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



