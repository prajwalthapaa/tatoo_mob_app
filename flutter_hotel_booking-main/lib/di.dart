import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_booking/core/util/int.dart';
import 'package:hotel_booking/data/datasources/Auth_remote_data_Source.dart';
import 'package:hotel_booking/data/datasources/hotel_local_data_source.dart';
import 'package:hotel_booking/data/datasources/hotel_remote_data_source.dart';
import 'package:hotel_booking/data/datasources/tattoo_remote_DAta_Source.dart';
import 'package:hotel_booking/data/models/hotel_model.dart';
import 'package:hotel_booking/data/repositories/IAuthRepository.dart';
import 'package:hotel_booking/data/repositories/hotel_repository_impl.dart';
import 'package:hotel_booking/domain/repositories/AuthRepository.dart';
import 'package:hotel_booking/domain/repositories/hotel_repository.dart';
import 'package:hotel_booking/domain/repositories/tattoRepository.dart';
import 'package:hotel_booking/domain/usecases/AuthUseCase.dart';
import 'package:hotel_booking/domain/usecases/getTattooUseCase.dart';
import 'package:hotel_booking/domain/usecases/get_favorite_hotels_usecase.dart';
import 'package:hotel_booking/domain/usecases/get_hotels_usecase.dart';
import 'package:hotel_booking/domain/usecases/remove_favorite_usecase.dart';
import 'package:hotel_booking/domain/usecases/set_favorite_usecase.dart';
import 'package:hotel_booking/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:hotel_booking/presentation/bloc/tattooBloc/tatto_bloc.dart';

import 'data/repositories/tattoo_RepositoryImpl.dart';

final di = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HotelModelAdapter());

  //Local Data
  final hotelBox = await Hive.openBox<HotelModel>('favorites');

  //Rest client
  di.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: 30.seconds,
        receiveTimeout: 15.seconds,
      ),
    ),
  );

  // Data sources
  di.registerLazySingleton<HotelLocalDataSource>(
    () => HotelLocalDataSourceImpl(hotelBox: hotelBox),
  );
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      dio: di(),
    ),
  );
  di.registerLazySingleton<TattooRemoteDataSource>(
    () => TattooRemoteDataSource(
      dio: di(),
    ),
  );

  // di.registerLazySingleton<HotelRemoteDataSource>(
  //   () => HotelRemoteDataSourceMockImpl(),
  // );

  di.registerLazySingleton<HotelRemoteDataSource>(
    () => HotelRemoteDataSourceImpl(
      dio: di(),
    ),
  );

  // Repository
  di.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
    ),
  );
  di.registerLazySingleton<AuthRepository>(() => IAuthRepository(dataSource: di()));
  di.registerLazySingleton<TattooRepository>(() => ITattoRepository(dataSource: di()));

  // Use cases
  di.registerLazySingleton(
    () => GetHotelsUseCase(di()),
  );
  di.registerLazySingleton(
    () => GetTattooUseCase(di()),
  );
  di.registerLazySingleton(
    () => AuthUseCase(di()),
  );

  di.registerLazySingleton(
    () => GetFavoriteHotelsUseCase(di()),
  );

  di.registerLazySingleton(
    () => SetFavoriteUseCase(di()),
  );

  di.registerLazySingleton(
    () => RemoveFavoriteUseCase(di()),
  );

  di.registerSingleton<AuthBloc>(
    AuthBloc(authUseCase: di()),
  );
  di.registerSingleton<TattooBloc>(
    TattooBloc(useCase: di()),
  );
}
