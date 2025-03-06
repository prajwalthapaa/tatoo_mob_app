import 'package:hive/hive.dart';
import 'package:hotel_booking/domain/entities/hotel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class HotelModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final bool isFavorite;

  const HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });

  factory HotelModel.fromEntity(final Hotel hotel) {
    return HotelModel(
      id: hotel.id,
      name: hotel.name,
      description: hotel.description,
      image: hotel.image,
      isFavorite: hotel.isFavorite,
    );
  }

  factory HotelModel.fromJson(final Map<String, dynamic> json) {
    return HotelModel(
      id: "${json['hotel_id']}",
      name: json['property']['name'],
      description: json['accessibilityLabel'],
      image: json['property']['photoUrls'][0],
      isFavorite: false,
    );
  }

  HotelModel copyWith({
    final String? id,
    final String? name,
    final String? description,
    final String? image,
    final bool? isFavorite,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Hotel toEntity() {
    return Hotel(
      id: id,
      name: name,
      description: description,
      image: image,
      isFavorite: isFavorite,
    );
  }

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}

extension HotelModelExt on List<HotelModel> {
  Future<List<HotelModel>> mock(final int count) async {
    //delay 1 sec
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      count,
      (final index) => HotelModel(
        id: index.toString(),
        name: 'Hotel $index',
        description: 'Description $index',
        image: 'https://picsum.photos/256/64',
      ),
    );
  }
}
