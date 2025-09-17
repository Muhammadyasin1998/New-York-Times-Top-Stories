// features/auth/presentation/cubit/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:nyt_top_stories/features/auth/domain/entities/user_entity.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final UserEntity? user;
  final String? errorMessage;
  final bool isAuthenticated;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  factory AuthState.initial() => const AuthState();

  @override
  List<Object?> get props => [isLoading, user, errorMessage, isAuthenticated];
}
