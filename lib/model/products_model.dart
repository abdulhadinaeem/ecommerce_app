import 'package:hive_flutter/adapters.dart';
part 'products_model.g.dart';

@HiveType(typeId: 1)
class Products {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? price;
  @HiveField(3)
  int? quantity;
  @HiveField(4)
  int? total;
  @HiveField(5)
  double? discountPercentage;
  @HiveField(6)
  int? discountedPrice;
  @HiveField(7)
  String? thumbnail;

  Products(
      {this.id,
      this.title,
      this.price,
      this.quantity,
      this.total,
      this.discountPercentage,
      this.discountedPrice,
      this.thumbnail});
}
