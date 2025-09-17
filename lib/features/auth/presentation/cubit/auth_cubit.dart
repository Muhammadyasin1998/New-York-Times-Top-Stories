// features/auth/presentation/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt_top_stories/features/auth/domain/usecases/login_usecase.dart';
import 'package:nyt_top_stories/features/auth/domain/usecases/get_saved_user_usecase.dart';
import 'package:nyt_top_stories/features/auth/domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final GetSavedUserUseCase getSavedUserUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.getSavedUserUseCase,
    required this.logoutUseCase,
  }) : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await loginUseCase(email, password);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        isAuthenticated: false,
      )),
      (_) async {
        final savedUser = await getSavedUserUseCase();
        savedUser.fold(
          (failure) => emit(state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
            isAuthenticated: false,
          )),
          (user) {
            emit(state.copyWith(
              isLoading: false,
              user: user,
              isAuthenticated: true,
            ));
          },
        );
      },
    );
  }

  Future<void> loadUser() async {
    emit(state.copyWith(isLoading: true));
    final result = await getSavedUserUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) {
        emit(state.copyWith(
          isLoading: false,
          user: user,
          isAuthenticated: user != null,
        ));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(AuthState.initial()),
    );
  }
}
