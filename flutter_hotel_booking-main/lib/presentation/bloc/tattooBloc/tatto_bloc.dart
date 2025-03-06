import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/domain/entities/tattoEntity.dart';
import 'package:hotel_booking/domain/usecases/getTattooUseCase.dart';

part 'tatto_event.dart';
part 'tatto_state.dart';

class TattooBloc extends Bloc<TattooEvent, TattooState> {
  final GetTattooUseCase useCase;

  TattooBloc({required this.useCase}) : super(InitialTattoState()) {
    on<LoadTattoosEvent>((event, emit) async {
      print("from bloc");
      emit(TattoLoadingState());
      try {
        final tattoos = await useCase.getTattos();
        emit(TattooSuccessState(tattoos: tattoos));
      } catch (e) {
        emit(TattoErrorState(e.toString()));
      }
    });
  }
}
