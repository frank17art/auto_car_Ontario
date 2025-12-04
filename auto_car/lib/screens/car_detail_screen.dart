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
  Car? _currentCar;

  @override
  void initState() {
    super.initState();
    _carFuture = _carRepository.getCarById(widget.carId);
    _carFuture.then((car) {
      setState(() => _currentCar = car);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du véhicule'),
        backgroundColor: const Color.fromARGB(255, 4, 16, 26),
      ),
      body: FutureBuilder<Car?>(
        future: _carFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                // Image de la voiture
                Stack(
                  children: [
                    Image.network(
                      car.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
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
                          color:
                              car.isAvailable ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          car.isAvailable ? 'Disponible' : 'Indisponible',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Infos principales
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Marque et modèle
                      Text(
                        '${car.brand} ${car.model}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Catégorie et année
                      Text(
                        '${car.category} • ${car.year}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Prix
                      Text(
                        '${car.price.toStringAsFixed(0)}  ',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(33, 150, 243, 1),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Détails de la voiture
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

                      const SizedBox(height: 24),

                      // Description
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

                      const SizedBox(height: 24),

                      // Informations du vendeur
                      FutureBuilder<Vendor?>(
                        future:
                            _vendorRepository.getVendorById(car.vendorId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          if (snapshot.data == null) {
                            return const SizedBox.shrink();
                          }

                          final vendor = snapshot.data!;

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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${vendor.rating} (${vendor.reviewCount} avis)',
                                          style:
                                              const TextStyle(fontSize: 14),
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
                        },
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FutureBuilder<Car?>(
        future: _carFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/contact',
                  arguments: snapshot.data!,
                );
              },
              label: const Text('Contacter le vendeur'),
              icon: const Icon(Icons.message),
              backgroundColor: Colors.blue,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

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