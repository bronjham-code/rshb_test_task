class ProductFarmer {
  final int id;
  final String title;

  ProductFarmer({this.id, this.title});

  static ProductFarmer fromMap(Map<String, dynamic> map) =>
      ProductFarmer(id: map['id'], title: map['title']);
}
