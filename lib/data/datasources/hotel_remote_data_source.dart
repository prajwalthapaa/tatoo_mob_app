// import 'package:dio/dio.dart';
// import 'package:hotel_booking/data/models/hotel_model.dart';
//
// abstract class HotelRemoteDataSource {
//   Future<List<HotelModel>> getHotels();
// }
//
// class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
//   final Dio dio;
//
//   HotelRemoteDataSourceImpl({required this.dio});
//
//   @override
//   Future<List<HotelModel>> getHotels() async {
//     try {
//       final response = await dio.get(
//         'https://booking-com15.p.rapidapi.com/api/v1/hotels/searchHotels',
//         options: Options(
//           headers: {
//             'x-rapidapi-host': 'booking-com15.p.rapidapi.com',
//             'x-rapidapi-key':
//                 'b7e44eaa80mshb849800de65a30ap14073cjsneb66226d8116',
//           },
//         ),
//         queryParameters: {
//           'dest_id': '-2092174',
//           'search_type': 'CITY',
//           'arrival_date': '2024-12-29',
//           'departure_date': '2024-12-31',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> hotels = response.data['data']['hotels'];
//         var x =  hotels.map((final json) => HotelModel.fromJson(json)).toList();
//         return x;
//       } else {
//         throw Exception('Failed to load hotels');
//       }
//     } catch (e) {
//       throw Exception('Failed to load hotels: $e');
//     }
//   }
// }
//
// class HotelRemoteDataSourceMockImpl implements HotelRemoteDataSource {
//   @override
//   Future<List<HotelModel>> getHotels() async {
//     return <HotelModel>[].mock(10);
//   }
// }
