import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/auth/models/auth_result.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';

// final isLoggedInProvider = Provider.autoDispose<bool>((ref) {
//   return ref.watch(authStateProvider).result == AuthResult.success;
// });

part 'is_logged_in_provider.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  return ref.watch(authStateProvider).result == AuthResult.success;
}
