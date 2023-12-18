import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

final saveSellProvider = FutureProvider.autoDispose.family<String, Sell>((ref, sell) {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  final newKey = userRef.child(SELL).push().key;

  if (newKey == null) {
    throw Exception("Could not create sell");
  }
  final savable = sell.copyWith(key: newKey);
  userRef.child(SELL).child(newKey).set(savable.toJson());

  return newKey;
});
