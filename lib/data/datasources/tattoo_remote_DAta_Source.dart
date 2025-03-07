import 'package:dio/dio.dart';

import '../../domain/entities/tattoEntity.dart';

class TattooRemoteDataSource {
  final Dio dio;
  TattooRemoteDataSource({required this.dio});
  Future<List<TattooEntity>> getTattos() async {
    try {
      final response = await dio.get("http://10.0.2.2:8000/api/tattoo");

      if (response.statusCode == 200) {
        // Assuming response.data contains a list of tattoos
        List<dynamic> tattoosData = response.data;

        // Map each tattoo from JSON to TattooEntity and return as a list
        List<TattooEntity> tattoos = tattoosData.map((tattooJson) => TattooEntity.fromJson(tattooJson)).toList();

        return tattoos;
      } else {
        throw Exception('Failed to load tattoos');
      }
    } catch (e) {
      throw Exception('Failed to load tattoos: $e');
    }
  }
}
