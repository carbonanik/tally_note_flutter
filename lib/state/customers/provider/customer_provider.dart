import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/util/log.dart';

final customersProvider = StreamProvider.autoDispose<Iterable<Customer>>((ref) {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  final controller = StreamController<Iterable<Customer>>();

  final query = userRef.child(CUSTOMER).orderByChild("lastEdited");

  query.onValue.listen((event) {
    final snapshot = event.snapshot;

    final list  = snapshot.children.toList().reversed.map((element) {
      final customer = Customer.fromJson(element.value as Map);
      // "${DateTime.fromMillisecondsSinceEpoch(customer.lastEdited)}->${customer.lastEdited}->${customer.name}".log();
      return customer;
    });

    controller.sink.add(list);
  });
  return controller.stream;
});
