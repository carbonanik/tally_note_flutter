import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';
import 'package:tally_note_flutter/state/sell/notifier/create_sell_notifier.dart';

final createSellNotifierProvider = StateNotifierProvider.autoDispose.family<CreateSellNotifier, AsyncValue<Sell>, String>(
  (ref, customerKey) => CreateSellNotifier(ref, customerKey),
);
