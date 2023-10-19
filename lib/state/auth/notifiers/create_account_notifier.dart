import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/backend/authenticator.dart';
import 'package:tally_note_flutter/state/auth/constant/constant.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/models/create_account_state.dart';
import 'package:tally_note_flutter/state/auth/models/create_account_result.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';

class CreateAccountNotifier extends StateNotifier<CreateAccountState> {
  final _authenticator = const Authenticator();
  String? storeVerificationId;
  String? _password;
  String? _phone;
  final Ref ref;

  CreateAccountNotifier({required this.ref}) : super(const CreateAccountState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = CreateAccountState(result: CreateAccountResult.alreadyLoggedIn);
    }
  }

  storeEmailPassword(String phone, String password) {
    _phone = phone;
    _password = password;
  }

  Future<void> createUser(String phone) async {
    state = state.copiedWithIsLoading(true);

    final email = phone + fakeEmailDomain;
    final accountExist = await _authenticator.accountExists(email);
    if (accountExist) {
      print("account exists");
      print('email: $email');
      state = CreateAccountState(result: CreateAccountResult.accountExists);
      return;
    }
    _authenticator.verifyPhone(
      phoneNumber: phone,
      success: (credential) async {
        await signInWithCredential(credential);
        print("success");
        print('credential: $credential');
      },
      codeSent: (verificationId, resendToken) async {
        state = CreateAccountState(result: CreateAccountResult.verificationCodeSent);
        storeVerificationId = verificationId;
        print("code Send0");
        print('verificationId: $verificationId');
      },
      timeout: (verificationId) {
        state = CreateAccountState(result: CreateAccountResult.timeout);
        print("timeout");
        print('verificationId: $verificationId');
      },
      failed: (message) {
        print("failed");
        print('message: $message');
        state = CreateAccountState(result: CreateAccountResult.failed);
      },
    );
  }


  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    state = state.copiedWithIsLoading(true);
    final authResult = await _authenticator.signInWithPhoneAuthCredential(credential);
    if (authResult == AuthResult.failure) {
      state = CreateAccountState(result: CreateAccountResult.failed);
      return;
    }
    final email = _phone! + fakeEmailDomain;
    _authenticator.linkEmailPassword(
      email,
      _password!,
      (success, authCredential) async {
        if (success) {
          await ref.read(authStateProvider.notifier).updateByCreateAccount(AuthResult.success);
          state = CreateAccountState(result: CreateAccountResult.successful);
        } else {
          state = CreateAccountState(result: CreateAccountResult.failed);
        }
      },
    );
  }

  Future<void> matchVerificationCode(String smsCode) async {
    if (storeVerificationId == null) return;
    final credential = await _authenticator.matchVerificationCode(storeVerificationId!, smsCode);
    await signInWithCredential(credential);
  }
}
