import 'package:auto_car/models/contact_request.dart';

class ContactRequestRepository {
  static final List<ContactRequest> _mockRequests = [];
  static int _idCounter = 1;

  /// Crée une nouvelle demande de contact
  Future<ContactRequest> createContactRequest({
    required String userId,
    required String carId,
    required String vendorId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final request = ContactRequest(
      id: 'request_${_idCounter++}',
      userId: userId,
      carId: carId,
      vendorId: vendorId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      message: message,
      createdAt: DateTime.now(),
      status: 'sent',
    );

    _mockRequests.add(request);
    return request;
  }

  /// Récupère toutes les demandes de contact
  Future<List<ContactRequest>> getAllRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_mockRequests);
  }

  /// Récupère les demandes d'un utilisateur spécifique
  Future<List<ContactRequest>> getRequestsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockRequests
        .where((request) => request.userId == userId)
        .toList();
  }

  /// Récupère les demandes pour une voiture spécifique
  Future<List<ContactRequest>> getRequestsByVendor(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockRequests
        .where((request) => request.vendorId == vendorId)
        .toList();
  }

  /// Récupère une demande par son ID
  Future<ContactRequest?> getRequestById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockRequests.firstWhere((request) => request.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Met à jour le statut d'une demande
  Future<ContactRequest?> updateRequestStatus(
    String requestId,
    String newStatus,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockRequests.indexWhere((request) => request.id == requestId);
    if (index == -1) return null;

    final updatedRequest = ContactRequest(
      id: _mockRequests[index].id,
      userId: _mockRequests[index].userId,
      carId: _mockRequests[index].carId,
      vendorId: _mockRequests[index].vendorId,
      firstName: _mockRequests[index].firstName,
      lastName: _mockRequests[index].lastName,
      email: _mockRequests[index].email,
      phone: _mockRequests[index].phone,
      message: _mockRequests[index].message,
      createdAt: _mockRequests[index].createdAt,
      status: newStatus,
    );

    _mockRequests[index] = updatedRequest;
    return updatedRequest;
  }

  /// Supprime une demande
  Future<bool> deleteRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final initialLength = _mockRequests.length;
    _mockRequests.removeWhere((request) => request.id == requestId);
    return _mockRequests.length < initialLength;
  }

  /// Récupère les demandes non répondues
  Future<List<ContactRequest>> getPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockRequests
        .where((request) => request.status == 'pending')
        .toList();
  }

  /// Réinitialise les données (pour tests)
  void reset() {
    _mockRequests.clear();
    _idCounter = 1;
  }

  /// Récupère le nombre total de demandes
  Future<int> getTotalRequestCount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockRequests.length;
  }
}
