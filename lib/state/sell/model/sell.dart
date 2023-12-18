import 'package:tally_note_flutter/state/sell/constant/constant.dart';
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

  Sell.empty()
      : key = "",
        customerKey = "",
        customerName = "",
        date = "",
        totalPrice = "0",
        paid = "0",
        due = "0",
        beforeDue = "0",
        afterDue = "0",
        note = "",
        type = typeProduct,
        products = [],
        payment = "0";

  Sell copyWith({
    String? key,
    String? customerKey,
    String? customerName,
    String? date,
    String? totalPrice,
    String? paid,
    String? due,
    String? beforeDue,
    String? afterDue,
    String? note,
    String? type,
    List<Product>? products,
    String? payment,
  }) {
    return Sell(
      key: key ?? this.key,
      customerKey: customerKey ?? this.customerKey,
      customerName: customerName ?? this.customerName,
      date: date ?? this.date,
      totalPrice: totalPrice ?? this.totalPrice,
      paid: paid ?? this.paid,
      due: due ?? this.due,
      beforeDue: beforeDue ?? this.beforeDue,
      afterDue: afterDue ?? this.afterDue,
      note: note ?? this.note,
      type: type ?? this.type,
      products: products ?? this.products,
      payment: payment ?? this.payment,
    );
  }

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

  Map<String, Object?> toJson(){
    return {
      'key': key,
      'customerKey': customerKey,
      'customerName': customerName,
      'date': date,
      'totalPrice': totalPrice,
      'paid': paid,
      'due': due,
      'beforeDue': beforeDue,
      'afterDue': afterDue,
      'note': note,
      'type': type,
      'products': products.map((e) => e.toJson()).toList(),
      'payment': payment
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
