import 'package:hive/hive.dart';

part 'favorite_items_model.g.dart';

@HiveType(typeId: 2)
class FavoriteItemsModel {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? quantity;
  @HiveField(3)
  int? price;
  @HiveField(4)
  String? id;
  FavoriteItemsModel(
      {this.image, this.price, this.quantity, this.title, this.id});
}
