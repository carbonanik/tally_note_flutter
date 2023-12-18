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

  Customer.empty()
      : key = "",
        name = "",
        createdAt = "",
        lastEdited = 0,
        gender = "",
        phoneNo = "",
        address = "",
        totalTransaction = "0",
        totalDue = "0";

  Customer copyWith({
    String? key,
    String? name,
    String? createdAt,
    int? lastEdited,
    String? gender,
    String? phoneNo,
    String? address,
    String? totalTransaction,
    String? totalDue,
  }) {
    return Customer(
      key: key ?? this.key,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastEdited: lastEdited ?? this.lastEdited,
      gender: gender ?? this.gender,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
      totalTransaction: totalTransaction ?? this.totalTransaction,
      totalDue: totalDue ?? this.totalDue,
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'createdAt': createdAt,
      'lastEdited': lastEdited,
      'gender': gender,
      'phoneNo': phoneNo,
      'address': address,
      'totalTransaction': totalTransaction,
      'totalDue': totalDue,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
