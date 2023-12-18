import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/customers/provider/single_customer_provider.dart';
import 'package:tally_note_flutter/state/sell/constant/constant.dart';
import 'package:tally_note_flutter/state/sell/provider/sell_provider.dart';
import 'package:tally_note_flutter/util/log.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/customer/customer_detail_page.dart';
import 'package:tally_note_flutter/views/sell/create_new_sell_page.dart';
import 'package:tally_note_flutter/views/sell/sell.dart';
import 'package:tally_note_flutter/views/sell/sell_payment.dart';

class SellListPage extends ConsumerWidget {
  const SellListPage({
    required this.customerKey,
    super.key,
  });

  final String? customerKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(sellProvider(customerKey ?? ""));
    final customer = ref.watch(singleCustomerProvider(customerKey ?? ""));
    return Scaffold(
      appBar: MyAppBar(
        title: Text(customer.asData?.value.name ?? "Sell List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CustomerDetailPage(customerKey: customerKey);
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: FilledButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return CreateNewSellPage(customerKey: customerKey);
                }));
              },
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text("Sell"),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: FilledButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text("Payment"),
                ],
              ),
            ),
          ),
        ],
      ),
      body: s.map(
        data: (data) {
          final list = data.value.toList();
          return list.isNotEmpty
              ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final sellType = list[index].type;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: sellType == typeProduct
                          ? SellWidget(sell: list[index])
                          : SellPaymentWidget(sell: list[index]),
                    );
                  },
                )
              : _noSell(context);
        },
        error: (error) {
          return _noSell(context);
        },
        loading: (loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _noSell(BuildContext context) {
    return Center(
      child: Text(
        "No Sell",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
