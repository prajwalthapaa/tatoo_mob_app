import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/AuthUseCase.dart';

part 'auth_state.dart';
part 'auth_events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc({required this.authUseCase}) : super(InitialAuthState()) {
    // Event: Login
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      final response = await authUseCase.login(event.email, event.password);
      emit(AuthSuccessState(response));
    });

    // Event: Signup
    on<CreateAccountEvent>((event, emit) async {
      print("calling frombloc");
      emit(AuthLoadingState());
      final result = await authUseCase.createAccount(event.name, event.email, event.password);
      emit(AuthSuccessState(result));
    });

    // Event: Check Auth Status
    on<CheckAuthStatusEvent>((event, emit) async {
      final result = await authUseCase.isLoggedIn();
      if (result) {
        emit(AuthSuccessState(result));
      } else {
        emit(InitialAuthState());
      }
    });

    // Event: Logout
    on<LogoutEvent>((event, emit) async {
      await authUseCase.logout();
      emit(AuthLoggedOutState());
    });
  }
}
