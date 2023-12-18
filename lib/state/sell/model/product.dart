class Product {
  final String productName;
  final String detail;
  final String price;

  Product({
    required this.productName,
    required this.detail,
    required this.price,
  });

  factory Product.fromJson(Map json) {
    return Product(
      productName: json['productName'],
      detail: json['detail'],
      price: json['price'],
    );
  }

  Map toJson() {
    return {
      'productName': productName,
      'detail': detail,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'Product{productName: $productName, detail: $detail, price: $price}';
  }
}
