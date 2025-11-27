import 'package:auto_car/models/user.dart';

class UserRepository {
  // Mock data - utilisateur courant
  static User? _currentUser;

  static final Map<String, User> _mockUsers = {
    'user1': User(
      id: 'user1',
      firstName: 'jesmina',
      lastName: 'dosreis',
      email: 'jesminadosreis@email.com',
      phone: '+1 436 345 4554',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    'user2': User(
      id: 'user2',
      firstName: 'crhitian',
      lastName: 'kasay',
      email: 'chritiankasay@email.com',
      phone: '+1 418 264 5767',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  };

  /// Inscription d'un nouvel utilisateur
  Future<User?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Validation simple
    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    // Vérifier que l'email n'existe pas déjà
    if (_mockUsers.values.any((user) => user.email == email)) {
      return null;
    }

    final newUser = User(
      id: 'user${_mockUsers.length + 1}',
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      createdAt: DateTime.now(),
    );

    _mockUsers[newUser.id] = newUser;
    _currentUser = newUser;
    return newUser;
  }

  /// Connexion utilisateur
  Future<User?> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      final user = _mockUsers.values.firstWhere((user) => user.email == email);

      // En production, vérifier le mot de passe de manière sécurisée
      if (password.isNotEmpty) {
        _currentUser = user;
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Récupère l'utilisateur courant
  User? getCurrentUser() {
    return _currentUser;
  }

  /// Déconnexion
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  /// Récupère un utilisateur par son ID
  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockUsers[id];
  }

  /// Met à jour le profil utilisateur
  Future<User?> updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (_currentUser == null) return null;

    final updatedUser = User(
      id: _currentUser!.id,
      firstName: firstName,
      lastName: lastName,
      email: _currentUser!.email,
      phone: phone,
      profileImageUrl: _currentUser!.profileImageUrl,
      createdAt: _currentUser!.createdAt,
    );

    _mockUsers[updatedUser.id] = updatedUser;
    _currentUser = updatedUser;
    return updatedUser;
  }

  /// Vérifie si un utilisateur est connecté
  bool isLoggedIn() {
    return _currentUser != null;
  }

  /// Initialise avec un utilisateur de test
  void initWithTestUser() {
    _currentUser = _mockUsers['user1'];
  }

  /// Réinitialise l'état (pour les tests)
  void reset() {
    _currentUser = null;
  }
}
