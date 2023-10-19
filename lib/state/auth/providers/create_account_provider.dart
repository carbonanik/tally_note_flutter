import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/create_account_state.dart';
import 'package:tally_note_flutter/state/auth/notifiers/create_account_notifier.dart';

final createAccountProvider = StateNotifierProvider<CreateAccountNotifier, CreateAccountState>((ref) {
  return CreateAccountNotifier(ref: ref);
});