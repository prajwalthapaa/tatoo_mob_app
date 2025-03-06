import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/data/datasources/hotel_local_data_source.dart';
import 'package:hotel_booking/data/datasources/hotel_remote_data_source.dart';
import 'package:hotel_booking/data/models/hotel_model.dart';
import 'package:hotel_booking/data/repositories/hotel_repository_impl.dart';
import 'package:hotel_booking/domain/usecases/get_favorite_hotels_usecase.dart';
import 'package:hotel_booking/domain/usecases/get_hotels_usecase.dart';
import 'package:hotel_booking/domain/usecases/remove_favorite_usecase.dart';
import 'package:hotel_booking/domain/usecases/set_favorite_usecase.dart';
import 'package:hotel_booking/main.dart';
import 'package:hotel_booking/presentation/pages/hotels_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([HotelRemoteDataSource, HotelLocalDataSource])
void main() {
  late HotelRepositoryImpl repository;
  late MockHotelRemoteDataSource mockRemoteDataSource;
  late MockHotelLocalDataSource mockLocalDataSource;
  late GetHotelsUseCase getHotelsUseCase;
  late GetFavoriteHotelsUseCase getFavoriteHotelsUseCase;
  late SetFavoriteUseCase setFavoriteUseCase;
  late RemoveFavoriteUseCase removeFavoriteUseCase;

  setUp(() {
    mockRemoteDataSource = MockHotelRemoteDataSource();
    mockLocalDataSource = MockHotelLocalDataSource();
    repository = HotelRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    getHotelsUseCase = GetHotelsUseCase(repository);
    getFavoriteHotelsUseCase = GetFavoriteHotelsUseCase(repository);
    setFavoriteUseCase = SetFavoriteUseCase(repository);
    removeFavoriteUseCase = RemoveFavoriteUseCase(repository);
  });

  testWidgets('MyApp widget test', (final tester) async {
    final hotelModels = [
      const HotelModel(
        id: '1',
        name: 'Test Hotel',
        description: 'Test Description',
        image: 'test.jpg',
        isFavorite: false,
      ),
    ];

    when(mockRemoteDataSource.getHotels()).thenAnswer((final _) async => hotelModels);
    when(mockLocalDataSource.getFavoriteHotels()).thenAnswer((final _) async => []);

    await tester.pumpWidget(
      MyApp(),
    );
    await tester.pumpAndSettle();

    // Find the bottom navigation bar
    final bottomNavBar = find.byType(BottomNavigationBar);
    expect(bottomNavBar, findsOneWidget);

    // Verify navigation items
    expect(
      find.descendant(of: bottomNavBar, matching: find.text('Overview')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavBar, matching: find.text('Hotels')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavBar, matching: find.text('Favorites')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavBar, matching: find.text('Account')),
      findsOneWidget,
    );
  });
  testWidgets('Hotel tab - Load hotels', (final tester) async {
    final hotelModels = [
      const HotelModel(
        id: '1',
        name: 'Luxury Hotel',
        description: 'A luxurious hotel experience',
        image: '',
        isFavorite: false,
      ),
      const HotelModel(
        id: '2',
        name: 'Beach Resort',
        description: 'Beautiful beachfront resort',
        image: '',
        isFavorite: false,
      ),
    ];

    // Setup mock responses
    when(mockRemoteDataSource.getHotels()).thenAnswer((final _) async => hotelModels);
    when(mockLocalDataSource.getFavoriteHotels()).thenAnswer((final _) async => []);
    when(mockLocalDataSource.addToFavorites(any)).thenAnswer((final _) async => {});
    when(mockLocalDataSource.removeFromFavorites(any)).thenAnswer((final _) async => {});

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [],
            child: HotelsPage(),
          ),
        ),
      ),
    );

    // Initial loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();

    // Wait for data to load
    await tester.pumpAndSettle();

    // Verify hotels are loaded
    expect(find.text('Luxury Hotel'), findsOneWidget);
    expect(find.text('Beach Resort'), findsOneWidget);
  });

  testWidgets('Hotel tab - Error handling', (final tester) async {
    // Setup mock to throw error
    when(mockRemoteDataSource.getHotels()).thenThrow(Exception('Failed to fetch hotels'));
    when(mockLocalDataSource.getFavoriteHotels()).thenAnswer((final _) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              // BlocProvider<HotelBloc>(
              //   create: (final _) => HotelBloc(
              //     getHotelsUseCase: getHotelsUseCase,
              //     setFavoriteUseCase: setFavoriteUseCase,
              //     removeFavoriteUseCase: removeFavoriteUseCase,
              //   )..add(LoadHotels()),
              // ),
              // BlocProvider<FavoriteBloc>(
              //   create: (final context) => FavoriteBloc(
              //     getFavoriteHotelsUseCase: getFavoriteHotelsUseCase,
              //     removeFavoriteUseCase: removeFavoriteUseCase,
              //     hotelBloc: context.read<HotelBloc>(),
              //   ),
              // ),
            ],
            child: HotelsPage(),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify error state
    expect(find.text('Failed to fetch hotels'), findsOneWidget);
  });

  testWidgets('Hotel tab - Empty state', (final tester) async {
    // Setup mock to return empty list
    when(mockRemoteDataSource.getHotels()).thenAnswer((final _) async => []);
    when(mockLocalDataSource.getFavoriteHotels()).thenAnswer((final _) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              // BlocProvider<HotelBloc>(
              //   create: (final _) => HotelBloc(
              //     getHotelsUseCase: getHotelsUseCase,
              //     setFavoriteUseCase: setFavoriteUseCase,
              //     removeFavoriteUseCase: removeFavoriteUseCase,
              //   )..add(LoadHotels()),
              // ),
              // BlocProvider<FavoriteBloc>(
              //   create: (final context) => FavoriteBloc(
              //     getFavoriteHotelsUseCase: getFavoriteHotelsUseCase,
              //     removeFavoriteUseCase: removeFavoriteUseCase,
              //     hotelBloc: context.read<HotelBloc>(),
              //   ),
              // ),
            ],
            child: HotelsPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify empty state
    expect(find.text('No hotels found'), findsOneWidget);
    expect(find.text('Please try again later'), findsOneWidget);
  });
}
