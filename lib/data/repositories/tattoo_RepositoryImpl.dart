import '../../domain/entities/tattoEntity.dart';
import '../../domain/repositories/tattoRepository.dart';
import '../datasources/tattoo_remote_DAta_Source.dart';

class ITattoRepository implements TattooRepository {
  final TattooRemoteDataSource dataSource;
  ITattoRepository({required this.dataSource});
  @override
  Future<List<TattooEntity>> getTattos() async {
    return await dataSource.getTattos();
  }
}
