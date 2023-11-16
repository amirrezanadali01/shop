import 'dart:ffi';

class ProductsModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final String category;
  final String image;
  final RatingsModel ratings;

  ProductsModel(
      {required this.category,
      required this.description,
      required this.id,
      required this.image,
      required this.price,
      required this.ratings,
      required this.title});

  factory ProductsModel.fromJson(Map json) => ProductsModel(
      category: json['category'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
      ratings: RatingsModel.fromJson(json['rating']));
}

class RatingsModel {
  final Float rate;
  final int count;

  RatingsModel({required this.count, required this.rate});

  factory RatingsModel.fromJson(Map json) =>
      RatingsModel(count: json['rate'], rate: json['count']);
}
