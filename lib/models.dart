import 'dart:ffi';

class Products {
  final int id;
  final String title;
  final int price;
  final String description;
  final String category;
  final String image;
  final Ratings ratings;

  Products(
      {required this.category,
      required this.description,
      required this.id,
      required this.image,
      required this.price,
      required this.ratings,
      required this.title});

  factory Products.fromJson(Map json) => Products(
      category: json['category'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
      ratings: Ratings.fromJson(json['rating']));
}

class Ratings {
  final Float rate;
  final int count;

  Ratings({required this.count, required this.rate});

  factory Ratings.fromJson(Map json) =>
      Ratings(count: json['rate'], rate: json['count']);
}
