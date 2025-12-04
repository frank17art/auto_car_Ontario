import 'package:auto_car/models/car.dart';

class CarRepository {
  // Mock data - à remplacer par des appels API
  static final List<Car> _mockCars = [
    Car(
      id: '1',
      brand: 'Tesla',
      model: 'Model 3',
      year: 2023,
      price: 45000,
      category: 'Sedan',
      imageUrl:
          'https://cdn.automobile-propre.com/uploads/2013/08/Tesla-Model-3-18.jpg',
      description: 'Voiture électrique performante avec autonomie de 500km',
      mileage: 5000,
      fuelType: 'Électrique',
      isAvailable: true,
      vendorId: 'vendor1',
    ),
    Car(
      id: '2',
      brand: 'BMW',
      model: 'X5',
      year: 2022,
      price: 65000,
      category: 'SUV',
      imageUrl: 'https://thumbs.dreamstime.com/b/bmw-320d-13302109.jpg',
      description: 'SUV de luxe spacieux avec intérieur premium',
      mileage: 15000,
      fuelType: 'Essence',
      isAvailable: true,
      vendorId: 'vendor1',
    ),
    Car(
      id: '3',
      brand: 'Honda',
      model: 'Civic',
      year: 2021,
      price: 25000,
      category: 'Hatchback',
      imageUrl:
          'https://images.unsplash.com/photo-1589345619662-95a3c3b03e19?w=500',
      description: 'Voiture compacte économe en carburant',
      mileage: 40000,
      fuelType: 'Essence',
      isAvailable: true,
      vendorId: 'vendor2',
    ),
    Car(
      id: '4',
      brand: 'Audi',
      model: 'A4',
      year: 2020,
      price: 35000,
      category: 'Sedan',
      imageUrl:
          'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=500',
      description: 'Berline sportive avec finition Audi',
      mileage: 60000,
      fuelType: 'Diesel',
      isAvailable: false,
      vendorId: 'vendor2',
    ),
    Car(
      id: '5',
      brand: 'Toyota',
      model: 'RAV4',
      year: 2023,
      price: 38000,
      category: 'SUV',
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
      description: 'SUV fiable avec système hybride efficace',
      mileage: 8000,
      fuelType: 'Hybride',
      isAvailable: true,
      vendorId: 'vendor3',
    ),
  ];

  /// Récupère toutes les voitures
  Future<List<Car>> getAllCars() async {
    // Simulation d'un appel API avec délai
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockCars;
  }

  /// Récupère une voiture par son ID
  Future<Car?> getCarById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockCars.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Filtre les voitures par prix min/max
  Future<List<Car>> filterByPrice(double minPrice, double maxPrice) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockCars
        .where((car) => car.price >= minPrice && car.price <= maxPrice)
        .toList();
  }

  /// Filtre les voitures par catégorie
  Future<List<Car>> filterByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockCars.where((car) => car.category == category).toList();
  }

  /// Filtre les voitures par marque
  Future<List<Car>> filterByBrand(String brand) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockCars.where((car) => car.brand == brand).toList();
  }

  /// Récupère les voitures disponibles
  Future<List<Car>> getAvailableCars() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCars.where((car) => car.isAvailable).toList();
  }

  /// Recherche par texte (marque, modèle)
  Future<List<Car>> searchCars(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowerQuery = query.toLowerCase();
    return _mockCars
        .where(
          (car) =>
              car.brand.toLowerCase().contains(lowerQuery) ||
              car.model.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Récupère les voitures d'un vendeur spécifique
  Future<List<Car>> getCarsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCars.where((car) => car.vendorId == vendorId).toList();
  }

  /// Trie les voitures par prix (ascending ou descending)
  Future<List<Car>> sortByPrice(List<Car> cars, {bool ascending = true}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final sorted = List<Car>.from(cars);
    sorted.sort(
      (a, b) =>
          ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price),
    );
    return sorted;
  }

  /// Trie les voitures par année
  Future<List<Car>> sortByYear(List<Car> cars, {bool ascending = false}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final sorted = List<Car>.from(cars);
    sorted.sort(
      (a, b) => ascending ? a.year.compareTo(b.year) : b.year.compareTo(a.year),
    );
    return sorted;
  }
}
