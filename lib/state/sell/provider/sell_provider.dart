import 'dart:async';
import 'dart:core';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

final sellProvider = StreamProvider.autoDispose.family<Iterable<Sell>, String>((ref, customerKey) {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  if (customerKey.isEmpty) {
    throw Exception("Key is empty");
  }

  final controller = StreamController<Iterable<Sell>>();

  userRef.child(SELL).orderByChild("customerKey").equalTo(customerKey).onValue.listen((event) {
    final snapshot = event.snapshot;
    final list = (snapshot.value as Map<Object?, Object?>?)?.values.map((value) {
      return Sell.fromJson(value as Map);
    }).toList();

    list?.sort((a, b) => (DateTime.tryParse(b.date)?.millisecondsSinceEpoch ?? 0)
        .compareTo(DateTime.tryParse(a.date)?.millisecondsSinceEpoch ?? 0));

    controller.sink.add(list ?? []);
  });
  return controller.stream;
});
