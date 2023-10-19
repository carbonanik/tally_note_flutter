import 'package:tally_note_flutter/state/auth/models/reset_pass_result.dart';

class ResetPassState {
  final ResetPassResult? result;
  final bool isLoading;

  ResetPassState({
    required this.result,
    this.isLoading = false,
  });

  const ResetPassState.unknown()
      : isLoading = false,
        result = null;

  ResetPassState copiedWithIsLoading(bool isLoading) {
    return ResetPassState(result: result, isLoading: isLoading);
  }

  @override
  bool operator ==(covariant ResetPassState other) {
    return identical(this, other) || (result == other.result && isLoading == other.isLoading);
  }

  @override
  int get hashCode => Object.hash(result, isLoading);
}
