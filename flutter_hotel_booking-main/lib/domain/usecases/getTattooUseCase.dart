import 'package:hotel_booking/domain/repositories/tattoRepository.dart';

import '../entities/tattoEntity.dart';

class GetTattooUseCase {
  final TattooRepository repository;
  GetTattooUseCase(this.repository);
  Future<List<TattooEntity>> getTattos() async {
    return await repository.getTattos();
  }
}
