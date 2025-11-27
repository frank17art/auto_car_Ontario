class Car {
  final String id;
  final String brand;
  final String model;
  final int year;
  final double price;
  final String category; // SUV, Sedan, Hatchback, etc.
  final String imageUrl;
  final String description;
  final double mileage;
  final String fuelType;
  final bool isAvailable;
  final String vendorId;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.mileage,
    required this.fuelType,
    required this.isAvailable,
    required this.vendorId,
  });

  // Factory pour créer depuis JSON (utile pour API future)
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      mileage: (json['mileage'] as num).toDouble(),
      fuelType: json['fuelType'] as String,
      isAvailable: json['isAvailable'] as bool,
      vendorId: json['vendorId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'mileage': mileage,
      'fuelType': fuelType,
      'isAvailable': isAvailable,
      'vendorId': vendorId,
    };
  }
}

