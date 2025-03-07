import '../entities/tattoEntity.dart';

abstract class TattooRepository {
  Future<List<TattooEntity>> getTattos();
}
