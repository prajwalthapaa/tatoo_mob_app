import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tattoo_booking_app/core/util/int.dart';
import 'package:tattoo_booking_app/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:tattoo_booking_app/presentation/bloc/tattooBloc/tatto_bloc.dart';

import 'data/datasources/Auth_remote_data_Source.dart';
import 'data/datasources/tattoo_remote_DAta_Source.dart';
import 'data/repositories/IAuthRepository.dart';
import 'data/repositories/tattoo_RepositoryImpl.dart';
import 'domain/repositories/AuthRepository.dart';
import 'domain/repositories/tattoRepository.dart';
import 'domain/usecases/AuthUseCase.dart';
import 'domain/usecases/getTattooUseCase.dart';

final di = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  // Hive.registerAdapter(HotelModelAdapter());

  //Local Data
  // final hotelBox = await Hive.openBox<HotelModel>('favorites');

  //Rest client
  di.registerLazySingleton(() => Dio(BaseOptions(connectTimeout: 30.seconds, receiveTimeout: 15.seconds)));

  // Data sources
  // di.registerLazySingleton<HotelLocalDataSource>(
  //   () => HotelLocalDataSourceImpl(hotelBox: hotelBox),
  // );
  di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(dio: di()));
  di.registerLazySingleton<TattooRemoteDataSource>(() => TattooRemoteDataSource(dio: di()));

  // di.registerLazySingleton<HotelRemoteDataSource>(
  //   () => HotelRemoteDataSourceMockImpl(),
  // );

  // di.registerLazySingleton<HotelRemoteDataSource>(
  //   () => HotelRemoteDataSourceImpl(
  //     dio: di(),
  //   ),
  // );

  // Repository
  // di.registerLazySingleton<HotelRepository>(
  //   () => HotelRepositoryImpl(
  //     remoteDataSource: di(),
  //     localDataSource: di(),
  //   ),
  // );
  di.registerLazySingleton<AuthRepository>(() => IAuthRepository(dataSource: di()));
  di.registerLazySingleton<TattooRepository>(() => ITattoRepository(dataSource: di()));

  // Use cases
  // di.registerLazySingleton(
  //   () => GetHotelsUseCase(di()),
  // );
  di.registerLazySingleton(() => GetTattooUseCase(di()));
  di.registerLazySingleton(() => AuthUseCase(di()));

  // di.registerLazySingleton(
  //   () => GetFavoriteHotelsUseCase(di()),
  // );
  //
  // di.registerLazySingleton(
  //   () => SetFavoriteUseCase(di()),
  // );

  // di.registerLazySingleton(
  //   () => RemoveFavoriteUseCase(di()),
  // );

  di.registerSingleton<AuthBloc>(AuthBloc(authUseCase: di()));
  di.registerSingleton<TattooBloc>(TattooBloc(useCase: di()));
}
