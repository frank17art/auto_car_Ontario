import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/repositories/car_repository.dart';

class CarCard extends StatefulWidget {
  final Car car;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final bool initialIsFavorite;

  const CarCard({
    Key? key,
    required this.car,
    required this.onTap,
    this.onFavoriteTap,
    this.initialIsFavorite = false,
  }) : super(key: key);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  late bool _isFavorite;
  final CarRepository _carRepository = CarRepository();

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialIsFavorite;
  }

  Future<void> _toggleFavorite() async {
    try {
      if (_isFavorite) {
        // Retirer des favoris
        await _carRepository.removeFavorite(widget.car.id);
      } else {
        // Ajouter aux favoris
        await _carRepository.addFavorite(widget.car.id);
      }

      // Mettre à jour l'UI
      setState(() => _isFavorite = !_isFavorite);

      // Appeler le callback optionnel
      widget.onFavoriteTap?.call();

      // Afficher un message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isFavorite
                  ? '${widget.car.brand} ${widget.car.model} ajouté aux favoris'
                  : '${widget.car.brand} ${widget.car.model} retiré des favoris',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
<<<<<<< HEAD
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
=======
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec badge disponibilité
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    widget.car.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                ),

                // Badge de disponibilité
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.car.isAvailable ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.car.isAvailable ? 'Disponible' : 'Indisponible',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
<<<<<<< HEAD
=======

>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
                // Bouton favori
                Positioned(
                  top: 6,
                  left: 6,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
            // Détails de la voiture
=======

            // Détails de la voiture (compacté)
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Marque et modèle
                  Text(
                    '${widget.car.brand} ${widget.car.model}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  
                  // Catégorie et année
                  Text(
<<<<<<< HEAD
                    '${car.category} • ${car.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
=======
                    '${widget.car.category} • ${widget.car.year}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
                  ),
                  const SizedBox(height: 4),
                  
                  // Prix
                  Text(
<<<<<<< HEAD
                    '\$${car.price.toStringAsFixed(0)} ',
=======
                    '${widget.car.price.toStringAsFixed(0)} \$',
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 216, 5, 58),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Infos supplémentaires
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
<<<<<<< HEAD
                        '${car.mileage.toStringAsFixed(0)} km',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        car.fuelType,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
=======
                        '${widget.car.mileage.toStringAsFixed(0)} km',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        widget.car.fuelType,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> b3507f89e19743826cf55bbf1e3539ab6b78a5dc
