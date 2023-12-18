import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/customers/provider/remove_customer_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/single_customer_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/update_customer_provider.dart';
import 'package:tally_note_flutter/views/component/my_app_bar.dart';
import 'package:tally_note_flutter/views/component/my_snack_bar.dart';
import 'package:tally_note_flutter/views/customer/dialog/create_or_update_customer.dart';

class CustomerDetailPage extends ConsumerWidget {
  final String? customerKey;

  CustomerDetailPage({
    super.key,
    required this.customerKey,
  });

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(singleCustomerProvider(customerKey ?? ""));
    return Scaffold(
      appBar: MyAppBar(
        title: Text(customer.asData?.value.name ?? "Customer Detail"),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.blueGrey[900],
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 80),
                        Text(
                          "Gender",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Phone",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Address",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 80),
                        Text(
                          "Total Transaction",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          (customer.asData?.value.totalDue ?? "0").startsWith("-") ? "Adv" : "Due",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: customer.map(
                  data: (data) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Text(
                              data.value.gender,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              data.value.phoneNo,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              data.value.address,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 80),
                            Text(
                              data.value.totalTransaction,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              data.value.totalDue.startsWith("-")
                                  ? data.value.totalDue.substring(1)
                                  : data.value.totalDue,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error) {
                    return Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Error",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
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
                ),
              ),
            ],
          ),
          if (customer.hasValue)
            Positioned(
              bottom: 40,
              right: 30,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final updatedCustomer = await createOrUpdateCustomerDialog(
                        context,
                        customer.value,
                        nameController,
                        phoneController,
                        addressController,
                      );
                      // customer.log();
                      if (updatedCustomer != null) {
                        await ref.read(updateCustomerProvider(updatedCustomer).future);
                      } else {
                        showSnackBar(context, "Customer not Updated");
                      }
                      // createOrUpdateCustomerDialog(context, customer.value, nameController, phoneController, addressController)
                    },
                    child: const Text("Edit"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final delete = await _deleteCustomerDialog(context);
                      if (delete == true) {
                        final deleted = await ref.read(deleteCustomerProvider(customerKey ?? "").future);
                        if (deleted) {
                          showSnackBar(context, "Customer Deleted");
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Future<bool?> _deleteCustomerDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext dialogContext) {
        return ScaffoldMessenger(
          child: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: AlertDialog(
                title: const Text("Delete Customer?"),
                actions: <Widget>[
                  FilledButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text('Cancel'),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                    },
                  ),
                  FilledButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text('Confirm!'),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(true);
                    },
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
