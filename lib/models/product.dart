import 'package:flutter/material.dart';
import 'package:rshb_test_task/models/characteristic.dart';

class Product extends ChangeNotifier {
  final int id;
  final int categoryId;
  final int farmerId;
  final String title;
  final String unit;
  final double totalRating;
  final int ratingCount;
  final String image;
  final String shortDescription;
  final String description;
  final double price;
  final List<ProductCharacteristic> characteristicsList;

  Product(
      {this.id,
      this.categoryId,
      this.farmerId,
      this.title,
      this.unit,
      this.totalRating,
      this.ratingCount,
      this.image,
      this.shortDescription,
      this.description,
      this.price,
      this.characteristicsList});

  static Product fromMap(Map<String, dynamic> map) {
    List<ProductCharacteristic> characteristics;
    if (map['characteristics'] != null) {
      (map['characteristics'] as List).forEach((characteristic) {
        if (characteristics == null) {
          characteristics = List<ProductCharacteristic>();
        }
        characteristics.add(ProductCharacteristic.fromMap(characteristic));
      });
    }
    return Product(
        id: map['id'],
        categoryId: map['categoryId'],
        farmerId: map['farmerId'],
        title: map['title'],
        unit: map['unit'],
        totalRating: map['totalRating'].toDouble(),
        ratingCount: map['ratingCount'],
        image: map['image'],
        shortDescription: map['shortDescription'],
        description: map['description'],
        price: map['price'],
        characteristicsList: characteristics);
  }
}
