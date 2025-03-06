import 'package:equatable/equatable.dart';

class TattooEntity extends Equatable {
  final String? id;
  final String name;
  final String type;
  final String city;
  final String address;
  final String description;
  final double rating;
  final List<String> rooms;
  final int cheapestPrice;
  final bool featured;
  final String? photos;
  final String reservationStatus;

  const TattooEntity({
    this.id,
    required this.name,
    required this.type,
    required this.city,
    required this.address,
    required this.description,
    required this.rating,
    required this.rooms,
    required this.cheapestPrice,
    required this.featured,
    this.photos,
    required this.reservationStatus,
  });
  factory TattooEntity.fromJson(Map<String, dynamic> json) {
    return TattooEntity(
      id: json['_id'] as String?,
      name: json['name'] as String,
      type: json['type'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      rooms: List<String>.from(json['rooms'] as List),
      cheapestPrice: json['cheapestPrice'] as int,
      featured: json['featured'] as bool,
      photos: json['photos'] as String?,
      reservationStatus: json['reservationStatus'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        city,
        address,
        description,
        rating,
        rooms,
        cheapestPrice,
        featured,
        photos,
        reservationStatus,
      ];
}
