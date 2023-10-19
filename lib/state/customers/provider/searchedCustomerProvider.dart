import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tally_note_flutter/state/customers/models/customer.dart';
import 'package:tally_note_flutter/state/customers/provider/customer_provider.dart';
import 'package:tally_note_flutter/state/customers/provider/customer_search_text_provider.dart';

final searchedCustomerProvider = Provider<AsyncValue<Iterable<Customer>>>((ref) {
  final searchText = ref.watch(customerSearchTextProvider);
  if (searchText.isEmpty) {
    return AsyncValue.error(Exception("Search Box Empty"), StackTrace.empty);
  }
  final value = ref.read(customersProvider);
  return value.whenData((value) => value.where((element) => element.name.contains(searchText)));
});
