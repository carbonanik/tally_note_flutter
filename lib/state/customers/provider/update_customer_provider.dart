import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';

final updateCustomerProvider = FutureProvider.autoDispose.family<bool, Customer>((ref, customer) async {
  final userRef = ref.watch(userRefProvider);

  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  if (customer.key.isEmpty) {
    throw Exception("Customer key is empty");
  }

  final savableCustomer = customer.copyWith(
    lastEdited: DateTime.now().millisecondsSinceEpoch,
  );
  await userRef.child(CUSTOMER).child(customer.key).update(savableCustomer.toJson());

  return true;
});
