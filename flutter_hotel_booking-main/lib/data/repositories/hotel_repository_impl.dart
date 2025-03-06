import 'package:dartz/dartz.dart';
import 'package:hotel_booking/core/error/failures.dart';
import 'package:hotel_booking/data/datasources/hotel_local_data_source.dart';
import 'package:hotel_booking/data/datasources/hotel_remote_data_source.dart';
import 'package:hotel_booking/data/models/hotel_model.dart';
import 'package:hotel_booking/domain/entities/hotel.dart';
import 'package:hotel_booking/domain/repositories/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;
  final HotelLocalDataSource localDataSource;

  HotelRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Hotel>>> getFavoriteHotels() async {
    try {
      final hotels = await localDataSource.getFavoriteHotels();
      return Right(hotels.map((final hotel) => hotel.toEntity()).toList());
    } catch (e) {
      return const Left(CacheFailure('Failed to fetch favorite hotels'));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> getHotels() async {
    try {
      final hotels = await remoteDataSource.getHotels();
      final favoriteHotels = await localDataSource.getFavoriteHotels();
      final favoriteHotelIds =
          favoriteHotels.map((final hotel) => hotel.id).toSet();

      return Right(
        hotels.map((final hotel) {
          final hotelEntity = hotel.toEntity();
          if (favoriteHotelIds.contains(hotel.id)) {
            return hotelEntity.copyWith(isFavorite: true);
          }
          return hotelEntity;
        }).toList(),
      );
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch hotels'));
    }
  }

  @override
  Future<Either<Failure, Hotel>> setFavoriteHotel(final Hotel hotel) async {
    try {
      final hotelModel = HotelModel.fromEntity(hotel);
      final updatedHotel = hotel.copyWith(isFavorite: true);
      await localDataSource.addToFavorites(hotelModel);

      return Right(updatedHotel);
    } catch (e) {
      return const Left(CacheFailure('Failed to set favorite hotel'));
    }
  }

  @override
  Future<Either<Failure, Hotel>> removeFavoriteHotel(final Hotel hotel) async {
    try {
      final hotelModel = HotelModel.fromEntity(hotel);
      final updatedHotel = hotel.copyWith(isFavorite: false);
      await localDataSource.removeFromFavorites(hotelModel);

      return Right(updatedHotel);
    } catch (e) {
      return const Left(CacheFailure('Failed to remove favorite hotel'));
    }
  }
}
