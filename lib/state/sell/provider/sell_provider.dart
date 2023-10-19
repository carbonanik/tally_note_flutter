import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

final sellProvider = StreamProvider.autoDispose.family<Iterable<Sell>, String>((ref, customerId) {
  final userRef = ref.watch(userRefProvider);
  // if (userRef == null) {
  //   throw Exception("User is not logged in");
  // }

  final controller = StreamController<Iterable<Sell>>();


  userRef?.child(SELL).orderByChild("customerKey").equalTo(customerId).onValue.listen((event) {
    final snapshot = event.snapshot;
    final list = (snapshot.value as Map<Object?, Object?>?)?.values.map((value) {
      print(value);
      return Sell.fromJson(value as Map);
    });

    controller.sink.add(list ?? []);
  });
  return controller.stream;
});
