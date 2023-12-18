import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';

final addCustomerProvider = FutureProvider.autoDispose.family<bool, Customer>((ref, customer) async {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  final String? newKey = userRef.child(CUSTOMER).push().key;

  if (newKey?.isNotEmpty == true) {
    final savableCustomer = customer.copyWith(
      key: newKey,
      lastEdited: DateTime.now().millisecondsSinceEpoch,
    );
    // DateTime.now().millisecondsSinceEpoch.log();
    await userRef.child(CUSTOMER).child(newKey!).set(savableCustomer.toJson());
  }
  return newKey != null;
});
