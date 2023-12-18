import 'package:flutter/material.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/views/component/my_snack_bar.dart';

Future<Customer?> createOrUpdateCustomerDialog(
  BuildContext context,
  Customer? existingCustomer,
  TextEditingController nameController,
  TextEditingController phoneController,
  TextEditingController addressController,
) async {
  String name = existingCustomer?.name ?? "";
  String phoneNo = existingCustomer?.phoneNo ?? "";
  String address = existingCustomer?.address ?? "";

  nameController.text = name;
  phoneController.text = phoneNo;
  addressController.text = address;

  final title = existingCustomer == null ? 'Add Customer' : 'Update Customer';

  return showDialog<Customer?>(
    context: context,
    barrierDismissible: false, // user must tap button!
    useRootNavigator: false,
    builder: (BuildContext dialogContext) {
      return ScaffoldMessenger(
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Customer Name',
                    ),
                    onChanged: (value) => name = value,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                    onChanged: (value) => phoneNo = value,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              actions: <Widget>[
                FilledButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    child: Text('Cancel'),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                FilledButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    child: Text('OK'),
                  ),
                  onPressed: () {
                    Customer? customer;
                    if (name.isEmpty && (phoneNo.isEmpty || address.isEmpty)) {
                      const message = 'Please fill all fields';
                      showSnackBar(context, message);
                      customer = null;
                    } else {
                      if (existingCustomer != null) {
                        customer = existingCustomer.copyWith(
                          name: name,
                          phoneNo: phoneNo,
                          address: address,
                        );
                      } else {
                        customer = Customer.empty().copyWith(
                          name: name,
                          phoneNo: phoneNo,
                          address: address,
                        );
                      }

                      Navigator.of(dialogContext).pop(customer);
                    }
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
