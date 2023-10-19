import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/customers/provider/customer_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/customer_search_bar_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/customer_search_text_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/searchedCustomerProvider.dart';
import 'package:tally_note_flutter/views/sell/sell_list_page.dart';
import 'package:tally_note_flutter/views/setting/setting_page.dart';

class CustomerListPage extends ConsumerWidget {
  const CustomerListPage({super.key});

  Widget _searchTextField(WidgetRef ref) {
    return TextField(
      onChanged: (val) {
        ref.read(customerSearchTextProvider.notifier).state = val;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBar = ref.watch(showCustomerSearchBarProvider);
    final searchText = ref.watch(customerSearchTextProvider);

    final customerValue = ref.watch(customersProvider);
    final searchCustomerValue = ref.watch(searchedCustomerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: searchBar ? _searchTextField(ref) : const Text("Customer List"),
        actions: searchBar
            ? [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ref.read(showCustomerSearchBarProvider.notifier).state = false;
                  },
                )
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref.read(showCustomerSearchBarProvider.notifier).state = true;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                )
              ],
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // const SizedBox(height: kToolbarHeight),
            Expanded(child: _buildCustomerList(searchText.isEmpty ? customerValue : searchCustomerValue, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerList(
    AsyncValue<Iterable<Customer>> customerValue,
    BuildContext context,
  ) {
    return customerValue.map(
      data: (data) {
        final list = data.value.toList();
        return list.isNotEmpty
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      tileColor: Colors.grey[900],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SellListPage(
                              customerId: list[index].key,
                            ),
                          ),
                        );
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 8.0),
                        child: Text(list[index].name, style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text("Due: ${list[index].totalDue}"),
                      ),
                      // trailing: IconButton(icon: const Icon(Icons.add), onPressed: () {  },),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "Empty",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              );
      },
      error: (error) {
        // throw error;
        // return Text(error.toString());
        return Center(
          child: Text(
            "Empty",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        );
      },
      loading: (loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          ),
        );
      },
    );
  }
}
