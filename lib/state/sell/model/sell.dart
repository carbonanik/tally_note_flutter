import 'package:tally_note_flutter/state/sell/model/product.dart';

class Sell {
  final String key;
  final String customerKey;
  final String customerName;
  final String date;
  final String totalPrice;
  final String paid;
  final String due;
  final String beforeDue;
  final String afterDue;
  final String note;
  final String type;
  final List<Product> products;
  final String payment;

  Sell({
    required this.key,
    required this.customerKey,
    required this.customerName,
    required this.date,
    required this.totalPrice,
    required this.paid,
    required this.due,
    required this.beforeDue,
    required this.afterDue,
    required this.note,
    required this.type,
    required this.products,
    required this.payment,
  });

  factory Sell.fromJson(Map json) {
    return Sell(
      key: json['key'],
      customerKey: json['customerKey'],
      customerName: json['customerName'],
      date: json['date'],
      totalPrice: json['totalPrice'],
      paid: json['paid'],
      due: json['due'],
      beforeDue: json['beforeDue'],
      afterDue: json['afterDue'],
      note: json['note'],
      type: json['type'],
      products: (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList() ?? [],
      payment: json['payment'],
    );
  }
}
