import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/auth/models/reset_pass_state.dart';
import 'package:tally_note_flutter/state/auth/notifiers/reset_pass_notifier.dart';

final resetPassProvider = StateNotifierProvider<ResetPassNotifier, ResetPassState>((ref) {
  return ResetPassNotifier(ref: ref);
});