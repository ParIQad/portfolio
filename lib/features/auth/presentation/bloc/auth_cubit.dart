import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _dataSource;

  AuthCubit({AuthRemoteDataSource? dataSource}) 
      : _dataSource = dataSource ?? AuthRemoteDataSource(),
        super(AuthInitial());

  Future<void> login(String username, String password) async {
    if (username.trim().isEmpty || password.trim().isEmpty) {
      emit(const AuthFailure("Please enter username and password"));
      return;
    }

    emit(AuthLoading());

    try {
      final result = await _dataSource.login(username, password);

      if (result != null) {
        emit(AuthSuccess(result));
      } else {
        emit(const AuthFailure("Invalid credentials. Try again."));
      }
    } catch (e) {
      emit(const AuthFailure("An unexpected error occurred."));
    }
  }

  Future<void> logout(int userId) async {
    emit(AuthLogoutLoading());

    try {
      final success = await _dataSource.logout(userId);

      if (success) {
        emit(AuthLoggedOut());
      } else {
        // Even if API fails, we still log out locally
        emit(AuthLoggedOut());
      }
    } catch (e) {
      // Force logout even on error
      emit(AuthLoggedOut());
    }
  }
}