// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteItemsModelAdapter extends TypeAdapter<FavoriteItemsModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteItemsModel(
      image: fields[0] as String?,
      price: fields[3] as int?,
      quantity: fields[2] as int?,
      title: fields[1] as String?,
      id: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteItemsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
