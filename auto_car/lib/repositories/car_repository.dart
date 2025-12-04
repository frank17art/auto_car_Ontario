import 'package:auto_car/models/car.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
          'https://images.dealersync.com/2925/Photos/1173439/20240813184445374_IMG_4881.jpg?_=81dc306ad36dd0f0a03eaef4b0e32bee4e17cb06',
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
      imageUrl:
          'https://img.itautomotive.fr/image/?apikey=808e17022092975cb19595ec956baeb8&url=https://cdn.bymycar.eu/fr-bo/assets/images/vehicles/vo/2001666/200_2001666_3532769.jpg&h=1200&output=webp&q=70&output=webp',
      description: 'SUV de luxe spacieux avec intérieur premium',
      mileage: 15000,
      fuelType: 'Essence',
      isAvailable: true,
      vendorId: 'vendor1',
    ),
    Car(
      id: '2',
      brand: 'Lincoln',
      model: 'Navigator',
      year: 2024,
      price: 125000,
      category: 'SUV',
      imageUrl:
          'https://www.lincoln.com/is/image/content/dam/vdm_ford/live/en_us/lincoln/nameplate/navigator/2024/collections/dm/22_LCN_NAV_BLCP_53651.tif?croppathe=1_3x2&wid=1440',
      description: 'SUV de luxe spacieux avec intérieur premium',
      mileage: 5000,
      fuelType: 'Essence',
      isAvailable: true,
      vendorId: 'vendor1',
    ),
    Car(
      id: '4',
      brand: 'Audi',
      model: 'A4',
      year: 2020,
      price: 35000,
      category: 'Sedan',
      imageUrl:
          'https://i0.wp.com/blog.audiblainville.com/wp-content/uploads/2022/07/audi-a4-2020_550px1583790025301.jpg?w=800&ssl=1',
      description: 'Berline sportive avec finition Audi',
      mileage: 60000,
      fuelType: 'Diesel',
      isAvailable: false,
      vendorId: 'vendor2',
    ),
    Car(
      id: '2',
      brand: 'GMC',
      model: 'Elevator',
      year: 2026,
      price: 85000,
      category: 'SUV',
      imageUrl:
          'https://www.gmccanada.ca/content/dam/gmc/global/us/english/index/crossovers-suvs/2025-terrain/overview/trims/my25-terrain-mov-elevation-1920x1440-25PGTN00087.jpg?imwidth=1200',
      description: 'SUV de luxe spacieux avec intérieur premium',
      mileage: 1000,
      fuelType: 'Essence',
      isAvailable: true,
      vendorId: 'vendor1',
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

  // Ajoute ces méthodes à CarRepository

Future<bool> isFavorite(String carId) async {
  // À adapter selon ton système de stockage
  // Exemple avec SharedPreferences:
  final prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  return favorites.contains(carId);
}

Future<void> addFavorite(String carId) async {
  final prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  if (!favorites.contains(carId)) {
    favorites.add(carId);
    await prefs.setStringList('favorites', favorites);
  }
}

Future<void> removeFavorite(String carId) async {
  final prefs = await SharedPreferences.getInstance();
  final favorites = prefs.getStringList('favorites') ?? [];
  favorites.remove(carId);
  await prefs.setStringList('favorites', favorites);
}
}
