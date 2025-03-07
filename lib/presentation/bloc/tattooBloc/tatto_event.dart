part of 'tatto_bloc.dart';

abstract class TattooEvent extends Equatable {
  const TattooEvent();
  @override
  List<Object> get props => [];
}

class LoadTattoosEvent extends TattooEvent {}
