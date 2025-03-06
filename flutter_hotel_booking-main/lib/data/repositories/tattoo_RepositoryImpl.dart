import 'package:hotel_booking/data/datasources/tattoo_remote_DAta_Source.dart';
import 'package:hotel_booking/domain/entities/tattoEntity.dart';
import 'package:hotel_booking/domain/repositories/tattoRepository.dart';

class ITattoRepository implements TattooRepository {
  final TattooRemoteDataSource dataSource;
  ITattoRepository({required this.dataSource});
  @override
  Future<List<TattooEntity>> getTattos() async {
    return await dataSource.getTattos();
  }
}
