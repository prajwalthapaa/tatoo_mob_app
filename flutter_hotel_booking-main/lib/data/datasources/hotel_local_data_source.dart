import 'package:hive/hive.dart';
import 'package:hotel_booking/data/models/hotel_model.dart';

abstract class HotelLocalDataSource {
  Future<void> addToFavorites(final HotelModel hotel);
  Future<List<HotelModel>> getFavoriteHotels();
  Future<void> removeFromFavorites(final HotelModel hotel);
  Future<List<HotelModel>> getAllHotels();
}

class HotelLocalDataSourceImpl implements HotelLocalDataSource {
  final Box<HotelModel> hotelBox;

  HotelLocalDataSourceImpl({required this.hotelBox});

  @override
  Future<void> addToFavorites(final HotelModel hotel) async {
    await hotelBox.put(hotel.id, hotel.copyWith(isFavorite: true));
  }

  @override
  Future<List<HotelModel>> getFavoriteHotels() async {
    return hotelBox.values.where((final hotel) => hotel.isFavorite).toList();
  }

  @override
  Future<void> removeFromFavorites(final HotelModel hotel) async {
    await hotelBox.put(hotel.id, hotel.copyWith(isFavorite: false));
  }

  @override
  Future<List<HotelModel>> getAllHotels() async {
    return hotelBox.values.toList();
  }
}
