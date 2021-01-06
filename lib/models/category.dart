class ProductCategory {
  final int id;
  final String title;
  final String assetFilePath;

  ProductCategory({this.id, this.title, this.assetFilePath});

  static ProductCategory fromMap(Map<String, dynamic> map) => ProductCategory(
      id: map['id'], title: map['title'], assetFilePath: map['iconUri']);
}
