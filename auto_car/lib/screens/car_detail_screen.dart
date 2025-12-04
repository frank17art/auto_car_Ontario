import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/models/vendor.dart';
import 'package:auto_car/repositories/car_repository.dart';
import 'package:auto_car/repositories/vendor_repository.dart';

class CarDetailScreen extends StatefulWidget {
  final String carId;

  const CarDetailScreen({
    Key? key,
    required this.carId,
  }) : super(key: key);

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final CarRepository _carRepository = CarRepository();
  final VendorRepository _vendorRepository = VendorRepository();

  late Future<Car?> _carFuture;
  late Future<Vendor?> _vendorFuture;
  
  Car? _currentCar;
  Vendor? _currentVendor;

  @override
  void initState() {
    super.initState();
    _loadCarData();
  }

  void _loadCarData() {
    _carFuture = _carRepository.getCarById(widget.carId).then((car) {
      if (car != null) {
        setState(() {
          _currentCar = car;
          _vendorFuture = _vendorRepository.getVendorById(car.vendorId).then((vendor) {
            setState(() => _currentVendor = vendor);
            return vendor;
          });
        });
      }
      return car;
    });
  }

  void _contactVendor() {
    if (_currentCar != null) {
      Navigator.of(context).pushNamed(
        '/contact',
        arguments: _currentCar!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du véhicule'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Car?>(
        future: _carFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildCarDetailSkeleton();
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          }

          final car = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CarImageHeader(
                  imageUrl: car.imageUrl,
                  isAvailable: car.isAvailable,
                  onBackPressed: () => Navigator.pop(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CarTitleSection(car: car),
                      const SizedBox(height: 24),
                      _CarCharacteristicsSection(car: car),
                      const SizedBox(height: 24),
                      _CarDescriptionSection(car: car),
                      const SizedBox(height: 24),
                      if (_currentVendor != null)
                        _VendorSection(vendor: _currentVendor!),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _currentCar != null
          ? FloatingActionButton.extended(
              onPressed: _contactVendor,
              label: const Text('Contacter le vendeur'),
              icon: const Icon(Icons.message),
              backgroundColor: Colors.blue,
            )
          : null,
    );
  }

  Widget _buildCarDetailSkeleton() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  width: 200,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 32,
                  width: 150,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget pour l'en-tête avec l'image et le statut de disponibilité
class _CarImageHeader extends StatelessWidget {
  final String imageUrl;
  final bool isAvailable;
  final VoidCallback onBackPressed;

  const _CarImageHeader({
    required this.imageUrl,
    required this.isAvailable,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
          cacheHeight: 300,
          cacheWidth: 500,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: onBackPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isAvailable ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isAvailable ? 'Disponible' : 'Indisponible',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget pour le titre et les infos principales
class _CarTitleSection extends StatelessWidget {
  final Car car;

  const _CarTitleSection({required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${car.brand} ${car.model}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${car.category} • ${car.year}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${car.price.toStringAsFixed(0)} €',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

/// Widget pour les caractéristiques de la voiture
class _CarCharacteristicsSection extends StatelessWidget {
  final Car car;

  const _CarCharacteristicsSection({required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Caractéristiques',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _DetailRow('Kilométrage', '${car.mileage.toStringAsFixed(0)} km'),
        _DetailRow('Carburant', car.fuelType),
        _DetailRow('Année', car.year.toString()),
        _DetailRow('Catégorie', car.category),
      ],
    );
  }
}

/// Widget pour la description
class _CarDescriptionSection extends StatelessWidget {
  final Car car;

  const _CarDescriptionSection({required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          car.description,
          style: const TextStyle(fontSize: 14, height: 1.6),
        ),
      ],
    );
  }
}

/// Widget pour les infos du vendeur
class _VendorSection extends StatelessWidget {
  final Vendor vendor;

  const _VendorSection({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vendeur',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendor.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${vendor.rating} (${vendor.reviewCount} avis)',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                vendor.city,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget réutilisable pour une ligne de détail
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}