import 'dart:convert';

ProductModel productModelFromjson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelTojson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.description,
      required this.isFavourite,
      required this.price,
      required this.categoryId,
      this.qty});

  String image;
  String id, categoryId;
  bool isFavourite;
  String name;
  double price;
  String description;

  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"].toString(),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["categoryId"] ?? "",
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
        "categoryId": categoryId,
        "price": price,
        "qty": qty,
      };
  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? price,
    String? description,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        isFavourite: false,
        price: price != null ? double.parse(price) : this.price,
        image: image ?? this.image,
        qty: 1,
      );
}
