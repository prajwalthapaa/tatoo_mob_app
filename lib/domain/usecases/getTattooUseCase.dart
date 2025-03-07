import '../entities/tattoEntity.dart';
import '../repositories/tattoRepository.dart';

class GetTattooUseCase {
  final TattooRepository repository;
  GetTattooUseCase(this.repository);
  Future<List<TattooEntity>> getTattos() async {
    return await repository.getTattos();
  }
}
