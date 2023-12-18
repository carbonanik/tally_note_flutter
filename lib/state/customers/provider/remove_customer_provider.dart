import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';

final deleteCustomerProvider = FutureProvider.autoDispose.family<bool, String>((ref, customerKey) async {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  if (customerKey.isEmpty) {
    throw Exception("Key is empty");
  }

  await userRef.child(CUSTOMER).child(customerKey).set(null);
  return true;
});
