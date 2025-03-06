import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failures.dart';
import 'package:hotel_booking/domain/entities/hotel.dart';
import 'package:hotel_booking/domain/repositories/hotel_repository.dart';

class RemoveFavoriteUseCase {
  final HotelRepository repository;

  const RemoveFavoriteUseCase(this.repository);

  Future<Either<Failure, Hotel>> call(final Hotel hotel) async {
    return await repository.removeFavoriteHotel(hotel);
  }
}
