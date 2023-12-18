import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';

final singleCustomerProvider = FutureProvider.autoDispose.family<Customer, String>((ref, key) async {
  if (key.isNotEmpty) {
    final userRef = ref.watch(userRefProvider);

    final data = await userRef?.child(CUSTOMER).child(key).get();
    if (data != null ) {
      return Customer.fromJson(data.value as Map);
    }
    throw Exception("Customer not found");
  }
  throw Exception("Key is empty");
});