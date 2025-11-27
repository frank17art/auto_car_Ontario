class ContactRequest {
  final String id;
  final String userId;
  final String carId;
  final String vendorId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String message;
  final DateTime createdAt;
  final String status; // pending, sent, replied

  ContactRequest({
    required this.id,
    required this.userId,
    required this.carId,
    required this.vendorId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.message,
    required this.createdAt,
    required this.status,
  });

  factory ContactRequest.fromJson(Map<String, dynamic> json) {
    return ContactRequest(
      id: json['id'] as String,
      userId: json['userId'] as String,
      carId: json['carId'] as String,
      vendorId: json['vendorId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'carId': carId,
      'vendorId': vendorId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}

