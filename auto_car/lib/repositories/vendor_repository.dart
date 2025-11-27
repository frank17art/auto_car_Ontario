import 'package:auto_car/models/vendor.dart';

class VendorRepository {
  static final Map<String, Vendor> _mockVendors = {
    'vendor1': Vendor(
      id: 'vendor1',
      name: 'Tesla Motors',
      email: 'contact@teslamotors.com',
      phone: '+1 289 423 4567 ',
      address: '123 dudas west',
      city: 'barrie',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
      reviewCount: 156,
      isVerified: true,
    ),
    'vendor2': Vendor(
      id: 'vendor2',
      name: 'Premium Autos',
      email: 'contact@premiumautos.com',
      phone: '+1 436 345 567 5345',
      address: '456 ladwsone Central',
      city: 'oshawa',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.5,
      reviewCount: 89,
      isVerified: true,
    ),
    'vendor3': Vendor(
      id: 'vendor3',
      name: 'Garage du Centre',
      email: 'contact@garage-centre.com',
      phone: '+1 438 456 7956',
      address: '789 cardel ave',
      city: 'scaborought',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.2,
      reviewCount: 45,
      isVerified: false,
    ),
  };

  /// Récupère tous les vendeurs
  Future<List<Vendor>> getAllVendors() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockVendors.values.toList();
  }

  /// Récupère un vendeur par son ID
  Future<Vendor?> getVendorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockVendors[id];
  }

  /// Récupère les vendeurs vérifiés
  Future<List<Vendor>> getVerifiedVendors() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVendors.values.where((vendor) => vendor.isVerified).toList();
  }

  /// Recherche des vendeurs par nom ou ville
  Future<List<Vendor>> searchVendors(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowerQuery = query.toLowerCase();
    return _mockVendors.values
        .where(
          (vendor) =>
              vendor.name.toLowerCase().contains(lowerQuery) ||
              vendor.city.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Récupère les vendeurs triés par note (descending)
  Future<List<Vendor>> getVendorsSortedByRating() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sorted = _mockVendors.values.toList();
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted;
  }

  /// Récupère les vendeurs triés par nombre d'avis
  Future<List<Vendor>> getVendorsSortedByReviews() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sorted = _mockVendors.values.toList();
    sorted.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    return sorted;
  }

  /// Récupère les vendeurs par ville
  Future<List<Vendor>> getVendorsByCity(String city) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVendors.values.where((vendor) => vendor.city == city).toList();
  }

  /// Met à jour les informations d'un vendeur
  Future<Vendor?> updateVendor(String vendorId, Vendor updatedVendor) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (!_mockVendors.containsKey(vendorId)) {
      return null;
    }

    _mockVendors[vendorId] = updatedVendor;
    return updatedVendor;
  }

  /// Réinitialise les données (pour tests)
  void reset() {
    _mockVendors.clear();
    _mockVendors.addAll({
      'vendor1': Vendor(
      id: 'vendor1',
      name: 'Tesla Motors',
      email: 'contact@teslamotors.com',
      phone: '+1 289 423 4567 ',
      address: '123 dudas west',
      city: 'barrie',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
      reviewCount: 156,
      isVerified: true,
    ),
    'vendor2': Vendor(
      id: 'vendor2',
      name: 'Premium Autos',
      email: 'contact@premiumautos.com',
      phone: '+1 436 345 567 5345',
      address: '456 ladwsone Central',
      city: 'oshawa',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.5,
      reviewCount: 89,
      isVerified: true,
    ),
    'vendor3': Vendor(
      id: 'vendor3',
      name: 'Garage du Centre',
      email: 'contact@garage-centre.com',
      phone: '+1 438 456 7956',
      address: '789 cardel ave',
      city: 'scaborought',
      logoUrl: 'https://via.placeholder.com/150',
      rating: 4.2,
      reviewCount: 45,
      isVerified: false,
      ),
    });
  }
}
