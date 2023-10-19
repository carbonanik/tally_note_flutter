import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_note_flutter/state/auth/constant/constant.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/type_def/user_id.dart';

class Authenticator {
  const Authenticator();

  bool get isAlreadyLoggedIn => userId != null;

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  String get displayName => FirebaseAuth.instance.currentUser?.displayName ?? '';

  Future<AuthResult> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == userNotFound) {
        print('No user found for that email.');
      } else if (e.code == wrongPassword) {
        print('Wrong password provided for that user.');
      }
      return AuthResult.failure;
    }
  }

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String virificationId, int? resendToken) codeSent,
    required Function(String message) failed,
    required Function(PhoneAuthCredential credential) success,
    required Function(String verificationId) timeout,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: success,
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == invalidPhoneNumber) {
          print('The provided phone number is not valid.');
          failed('The provided phone number is not valid.');
        }
        print(e.message);
        failed("Unknown error");
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: timeout,
    );
  }

  Future<PhoneAuthCredential> matchVerificationCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    return credential;
  }

  Future<AuthResult> signInWithPhoneAuthCredential(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> linkEmailPassword(
    String email,
    String password,
    Function(bool success, AuthCredential? authCredential) isSuccessful,
  ) async {
    final credential = EmailAuthProvider.credential(email: email, password: password);
    final authCredential = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    if (authCredential != null) {
      isSuccessful(true, authCredential.credential);
    } else {
      isSuccessful(false, null);
    }
  }

  Future<void> changePassword(String email, String password) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(password);
  }

  Future<bool> accountExists(String email) async {
    final user = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return user.isNotEmpty;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
