import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/backend/authenticator.dart';
import 'package:tally_note_flutter/state/auth/constant/constant.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/models/reset_pass_result.dart';
import 'package:tally_note_flutter/state/auth/models/reset_pass_state.dart';

class ResetPassNotifier extends StateNotifier<ResetPassState> {
  final _authenticator = const Authenticator();
  String? storeVerificationId;
  String? _phone;
  final Ref ref;

  ResetPassNotifier({required this.ref}) : super(const ResetPassState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = ResetPassState(result: ResetPassResult.alreadyLoggedIn);
    }
  }

  Future<void> resetRequest(String phone) async {
    state = state.copiedWithIsLoading(true);

    _phone = phone;

    final email = phone + fakeEmailDomain;
    final accountExist = await _authenticator.accountExists(email);
    if (!accountExist) {
      state = ResetPassState(result: ResetPassResult.accountDoesNotExist);
      return;
    }
    _authenticator.verifyPhone(
      phoneNumber: phone,
      success: (credential) async {
        print("success");
        print('credential: $credential');
      },
      codeSent: (verificationId, resendToken) async {
        state = ResetPassState(result: ResetPassResult.verificationCodeSent);
        storeVerificationId = verificationId;
        print("code Send0");
        print('verificationId: $verificationId');
      },
      timeout: (verificationId) {
        state = ResetPassState(result: ResetPassResult.timeout);
        print("timeout");
        print('verificationId: $verificationId');
      },
      failed: (message) {
        print("failed");
        print('message: $message');
        state = ResetPassState(result: ResetPassResult.failed);
      },
    );
  }

  Future<void> matchVerificationCode(String smsCode) async {
    if (storeVerificationId == null) return;
    state = state.copiedWithIsLoading(true);
    final credential = await _authenticator.matchVerificationCode(storeVerificationId!, smsCode);
    final r = await _authenticator.signInWithCredential(credential);
    if (r == AuthResult.success) {
      state = ResetPassState(result: ResetPassResult.verificationCodeMatched);
      return;
    }
    state = ResetPassState(result: ResetPassResult.failed);
  }

  Future<void> changePass(String password) async {
    state = state.copiedWithIsLoading(true);
    final email = _phone! + fakeEmailDomain;
    await _authenticator.changePassword(email, password);
    await _authenticator.logout();
    state = ResetPassState(result: ResetPassResult.successful);
    print("success");
    // await ref.read(authStateProvider.notifier).updateByCreateAccount(AuthResult.success);
  }
}
