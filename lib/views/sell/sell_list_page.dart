import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/sell/provider/sell_provider.dart';
import 'package:tally_note_flutter/views/sell/sell.dart';

class SellListPage extends ConsumerWidget {
  const SellListPage({
    required this.customerId,
    super.key,
  });

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(sellProvider(customerId));
    return Scaffold(
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
                      child: SellWidget(sell: list[index]),
                    );
                    //   ListTile(
                    //   title: Text(list[index].customerName),
                    //   subtitle: Text("Due: ${list[index].afterDue}"),
                    // );
                  },
                )
              : Center(
                  child: Text(
                    "No Sell",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
        },
        error: (error) {
          return Text(error.toString());
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
}
