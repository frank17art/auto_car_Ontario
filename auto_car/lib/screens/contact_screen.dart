<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/repositories/contact_request_repository.dart';
import 'package:auto_car/repositories/user_repository.dart';
import 'package:auto_car/widgets/contact_form.dart';

class ContactScreen extends StatefulWidget {
  final Car car;

  const ContactScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactRequestRepository _contactRepository =
      ContactRequestRepository();
  final UserRepository _userRepository = UserRepository();
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    // Initialiser avec un utilisateur de test si nécessaire
    if (!_userRepository.isLoggedIn()) {
      _userRepository.initWithTestUser();
    }
  }

  Future<void> _handleFormSubmit(ContactFormData formData) async {
    final currentUser = _userRepository.getCurrentUser();

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur: Utilisateur non trouvé')),
      );
      return;
    }

    try {
      await _contactRepository.createContactRequest(
        userId: currentUser.id,
        carId: widget.car.id,
        vendorId: widget.car.vendorId,
        firstName: formData.firstName,
        lastName: formData.lastName,
        email: formData.email,
        phone: formData.phone,
        message: formData.message,
      );

      setState(() => _isSubmitted = true);

      // Afficher le message de succès
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Demande envoyée avec succès!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Attendre un peu avant de revenir
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demande de disponibilité'),
        backgroundColor: Colors.blue,
      ),
      body: _isSubmitted
          ? _buildSuccessScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Résumé de la voiture
                  Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vous contactez le vendeur pour:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.car.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.car.brand} ${widget.car.model}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.car.year} • ${widget.car.fuelType}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${widget.car.price.toStringAsFixed(0)} ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Formulaire
                  ContactForm(
                    initialFirstName: _userRepository
                        .getCurrentUser()
                        ?.firstName,
                    initialLastName: _userRepository.getCurrentUser()?.lastName,
                    initialEmail: _userRepository.getCurrentUser()?.email,
                    initialPhone: _userRepository.getCurrentUser()?.phone,
                    onSubmit: _handleFormSubmit,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 32),
            const Text(
              'Demande envoyée!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Votre demande de disponibilité pour ${widget.car.brand} ${widget.car.model} a été envoyée au vendeur.\n\nNous vous contacterons dès que possible.',
              style: const TextStyle(fontSize: 16, height: 1.6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Retour au catalogue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:auto_car/models/car.dart';
import 'package:auto_car/repositories/contact_request_repository.dart';
import 'package:auto_car/repositories/user_repository.dart';
import 'package:auto_car/widgets/contact_form.dart';

class ContactScreen extends StatefulWidget {
  final Car car;

  const ContactScreen({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactRequestRepository _contactRepository =
      ContactRequestRepository();
  final UserRepository _userRepository = UserRepository();
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    // Initialiser avec un utilisateur de test si nécessaire
    if (!_userRepository.isLoggedIn()) {
      _userRepository.initWithTestUser();
    }
  }

  Future<void> _handleFormSubmit(ContactFormData formData) async {
    final currentUser = _userRepository.getCurrentUser();
    
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur: Utilisateur non trouvé')),
      );
      return;
    }

    try {
      await _contactRepository.createContactRequest(
        userId: currentUser.id,
        carId: widget.car.id,
        vendorId: widget.car.vendorId,
        firstName: formData.firstName,
        lastName: formData.lastName,
        email: formData.email,
        phone: formData.phone,
        message: formData.message,
      );

      setState(() => _isSubmitted = true);

      // Afficher le message de succès
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Demande envoyée avec succès!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Attendre un peu avant de revenir
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demande de disponibilité'),
        backgroundColor: Colors.blue,
      ),
      body: _isSubmitted
          ? _buildSuccessScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Résumé de la voiture
                  Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vous contactez le vendeur pour:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.car.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.car.brand} ${widget.car.model}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.car.year} • ${widget.car.fuelType}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.car.price.toStringAsFixed(0)} €',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Formulaire
                  ContactForm(
                    initialFirstName: _userRepository.getCurrentUser()?.firstName,
                    initialLastName: _userRepository.getCurrentUser()?.lastName,
                    initialEmail: _userRepository.getCurrentUser()?.email,
                    initialPhone: _userRepository.getCurrentUser()?.phone,
                    onSubmit: _handleFormSubmit,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Demande envoyée!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Votre demande de disponibilité pour ${widget.car.brand} ${widget.car.model} a été envoyée au vendeur.\n\nNous vous contacterons dès que possible.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Retour au catalogue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> 60ba5c58994fd6f6b825817beced898338b6c5f1
