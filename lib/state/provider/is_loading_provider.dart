import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/auth/providers/auth_state_provider.dart';
import 'package:tally_note_flutter/state/auth/providers/create_account_provider.dart';
import 'package:tally_note_flutter/state/auth/providers/reset_pass_provider.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  return ref.watch(authStateProvider).isLoading || ref.watch(createAccountProvider).isLoading || ref.watch(resetPassProvider).isLoading;
}
