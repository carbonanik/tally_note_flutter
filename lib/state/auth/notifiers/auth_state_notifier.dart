import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/backend/authenticator.dart';
import 'package:tally_note_flutter/state/auth/constant/constant.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> signIn(String phone, String password) async {
    print("Anik");
    state = state.copiedWithIsLoading(true);
    final email = phone + fakeEmailDomain;
    final result = await _authenticator.loginWithEmailAndPassword(email, password);

    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> updateByCreateAccount(result) async {
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  void logout() async {
    await _authenticator.logout();
    state = const AuthState.unknown();
  }
}
