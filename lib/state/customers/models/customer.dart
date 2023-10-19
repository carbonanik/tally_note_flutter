class Customer {
  final String key;
  final String name;
  final String createdAt;
  final int lastEdited;
  final String gender;
  final String phoneNo;
  final String address;
  final String totalTransaction;
  final String totalDue;

  Customer({
    required this.key,
    required this.name,
    required this.createdAt,
    required this.lastEdited,
    required this.gender,
    required this.phoneNo,
    required this.address,
    required this.totalTransaction,
    required this.totalDue,
  });

  factory Customer.fromJson(Map json) {
    return Customer(
      key: json['key'],
      name: json['name'],
      createdAt: json['createdAt'],
      lastEdited: json['lastEdited'],
      gender: json['gender'],
      phoneNo: json['phoneNo'],
      address: json['address'],
      totalTransaction: json['totalTransaction'],
      totalDue: json['totalDue'],
    );
  }
}
