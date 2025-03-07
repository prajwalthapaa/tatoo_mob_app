part of 'tatto_bloc.dart';

abstract class TattooState extends Equatable {
  TattooState();
  @override
  List<Object> get props => [];
}

class InitialTattoState extends TattooState {}

class TattoLoadingState extends TattooState {}

class TattooSuccessState extends TattooState {
  final List<TattooEntity> tattoos;
  TattooSuccessState({required this.tattoos});

  @override
  List<Object> get props => [tattoos];
}

class TattoErrorState extends TattooState {
  final String message;

  TattoErrorState(this.message);
}
