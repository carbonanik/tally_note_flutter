import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/sell/model/product.dart';
import 'package:tally_note_flutter/state/sell/provider/create_sell_notifier_provider.dart';
import 'package:tally_note_flutter/util/log.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/sell/sell.dart';

class CreateNewSellPage extends ConsumerWidget {
  CreateNewSellPage({required this.customerKey, super.key});

  final String? customerKey;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final detailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSell = ref.watch(createSellNotifierProvider(customerKey ?? ""));
    return Scaffold(
      appBar: const MyAppBar(title: Text("Create New Sell")),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: asyncSell.map(
                  data: (data) => SellWidget(sell: data.value),
                  error: (error) => Center(
                    child: Text(
                      error.error.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  loading: (loading) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text("Product Name"),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Price"),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                    controller: detailController,
                    decoration: const InputDecoration(
                      label: Text("Detail"),
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty || priceController.text.isEmpty) {
                      return;
                    }
                    final product = Product(
                      productName: nameController.text,
                      detail: detailController.text,
                      price: priceController.text,
                    )..log();
                    await ref.read(createSellNotifierProvider(customerKey ?? "").notifier).addOrCreate(product);
                    nameController.clear();
                    detailController.clear();
                    priceController.clear();
                  },
                  child: const Text("Add Product"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
