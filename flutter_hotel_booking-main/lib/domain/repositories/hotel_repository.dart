import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failures.dart';
import 'package:hotel_booking/domain/entities/hotel.dart';

abstract class HotelRepository {
  Future<Either<Failure, List<Hotel>>> getFavoriteHotels();
  Future<Either<Failure, List<Hotel>>> getHotels();
  Future<Either<Failure, Hotel>> setFavoriteHotel(final Hotel hotel);
  Future<Either<Failure, Hotel>> removeFavoriteHotel(final Hotel hotel);
}
