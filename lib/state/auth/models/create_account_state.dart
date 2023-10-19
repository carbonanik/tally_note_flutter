import 'package:tally_note_flutter/state/auth/models/create_account_result.dart';

class CreateAccountState {
  final CreateAccountResult? result;
  final bool isLoading;

  CreateAccountState({
    required this.result,
    this.isLoading = false,
  });

  const CreateAccountState.unknown()
      : isLoading = false,
        result = null;

  CreateAccountState copiedWithIsLoading(bool isLoading) {
    return CreateAccountState(result: result, isLoading: isLoading);
  }

  @override
  bool operator ==(covariant CreateAccountState other) {
    return identical(this, other) || (result == other.result && isLoading == other.isLoading);
  }

  @override
  int get hashCode => Object.hash(result, isLoading);
}
