class Vendor {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String? logoUrl;
  final double rating;
  final int reviewCount;
  final bool isVerified;

  Vendor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    this.logoUrl,
    required this.rating,
    required this.reviewCount,
    required this.isVerified,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      logoUrl: json['logoUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isVerified: json['isVerified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'logoUrl': logoUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isVerified': isVerified,
    };
  }
}

