
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';
import 'package:tally_note_flutter/state/provider/user_ref_provider.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';

final singleSellProvider = FutureProvider.autoDispose.family<Sell, String>((ref, sellKey) async {
  if (sellKey.isEmpty) {
    throw Exception("Key is empty");
  }

  final userRef = ref.watch(userRefProvider);

  if (userRef == null) {
    throw Exception("User is not logged in");
  }

  final sell = await userRef.child(SELL).child(sellKey).get();
  if (!sell.exists) {
    throw Exception("Sell does not exist");
  } else {
    return Sell.fromJson(sell.value as Map);
  }

});