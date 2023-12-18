import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/customers/provider/single_customer_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/update_customer_provider.dart';
import 'package:tally_note_flutter/state/sell/model/product.dart';
import 'package:tally_note_flutter/state/sell/model/sell.dart';
import 'package:tally_note_flutter/state/sell/provider/save_sell_provider.dart';
import 'package:tally_note_flutter/state/sell/provider/single_sell_provider.dart';
import 'package:tally_note_flutter/state/sell/provider/update_sell_provider.dart';
import 'package:tally_note_flutter/util/log.dart';
import 'package:tally_note_flutter/util/time_util.dart';

class CreateSellNotifier extends StateNotifier<AsyncValue<Sell>> {
  CreateSellNotifier(this.ref, this.customerKey)
      : super(AsyncValue.data(Sell.empty().copyWith(customerKey: customerKey)));
  final Ref ref;
  final String customerKey;

  Future<void> addOrCreate(Product product) async {
    if (customerKey.isEmpty) return;
    final sell = state.value;
    if (sell == null) return;
    if (sell.key.isEmpty) {
      await _initialSellCreate(product);
    } else {
      await _addProduct(product);
    }
  }

  Future<void> _addProduct(Product product) async {
    final sell = state.value;
    if (sell!.key.isEmpty) return; // need to create sell first

    state = const AsyncValue.loading();
    try {
      final customer = await ref.read(singleCustomerProvider(customerKey).future);

      final totalDue = add(customer.totalDue, product.price);

      final newSell = sell.copyWith(
        products: [...sell.products, product],
        totalPrice: add(sell.totalPrice, product.price),
        due: add(sell.due, product.price),
        afterDue: totalDue,
      );

      final newCustomer = customer.copyWith(
        totalTransaction: add(customer.totalTransaction, product.price),
        totalDue: totalDue,
      );

      await ref.read(updateSellProvider(newSell).future);
      await ref.read(updateCustomerProvider(newCustomer).future);

      final refreshed = await ref.read(singleSellProvider(newSell.key).future);
      state = AsyncData(refreshed);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> _initialSellCreate(Product product) async {
    final sell = state.value;
    if (sell!.key.isNotEmpty) return; // create sell only when key is empty

    state = const AsyncValue.loading();

    try {
      final customer = await ref.read(singleCustomerProvider(customerKey).future)
        ..log();

      final totalTransaction = add(customer.totalTransaction, product.price);
      final totalDue = add(customer.totalDue, product.price);

      final newSell = sell.copyWith(
        customerName: customer.name,
        date: DateTimeString().now(),
        products: [product],
        totalPrice: product.price,
        due: product.price,
        beforeDue: customer.totalDue,
        afterDue: totalDue,
      );

      final newCustomer = customer.copyWith(
        totalTransaction: totalTransaction,
        totalDue: totalDue,
      );

      newSell.log();
      newCustomer.log();

      await ref.read(updateCustomerProvider(newCustomer).future);
      final sellKey = await ref.read(saveSellProvider(newSell).future);

      final refreshed = await ref.read(singleSellProvider(sellKey).future);
      state = AsyncData(refreshed);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

String add(String one, String two) {
  return ((double.tryParse(one) ?? 0.0) + (double.tryParse(two) ?? 0.0)).toStringAsFixed(2);
}
