class ProductCharacteristic {
  final String title;
  final String value;

  ProductCharacteristic({this.title, this.value});

  static ProductCharacteristic fromMap(Map<String, dynamic> map) =>
      ProductCharacteristic(title: map['title'], value: map['value']);
}
