import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

final updateSellProvider = FutureProvider.autoDispose.family<bool, Sell>((ref, sell) async {
  final userRef = ref.watch(userRefProvider);
  if (userRef == null) {
    throw Exception("User is not logged in");
  }
  if (sell.key.isEmpty) {
    throw Exception("Sell key is empty");
  }
  await userRef.child(SELL).child(sell.key).update(sell.toJson());
  return true;
});
