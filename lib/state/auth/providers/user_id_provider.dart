import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';
import 'package:tally_note_flutter/state/auth/type_def/user_id.dart';


final userIdProvider = Provider<UserId?>((ref) {
  return ref.watch(authStateProvider).userId;
});
