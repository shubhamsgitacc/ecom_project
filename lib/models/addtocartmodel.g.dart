// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtocartmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelsAdapter extends TypeAdapter<CartModels> {
  @override
  final int typeId = 2;

  @override
  CartModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModels(
      id: fields[0] as int?,
      name: fields[1] as String?,
      image: fields[2] as String?,
      actualprice: fields[3] as String?,
      finalprice: fields[4] as String?,
      quantity: fields[5] as int?,
      weight: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartModels obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.actualprice)
      ..writeByte(4)
      ..write(obj.finalprice)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
