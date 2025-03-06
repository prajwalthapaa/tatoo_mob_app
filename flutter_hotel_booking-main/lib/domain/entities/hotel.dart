import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool isFavorite;

  const Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        isFavorite,
      ];

  Hotel copyWith({
    final String? id,
    final String? name,
    final String? description,
    final String? image,
    final bool? isFavorite,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
