// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressmodelAdapter extends TypeAdapter<Addressmodel> {
  @override
  final int typeId = 3;

  @override
  Addressmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addressmodel(
      address: fields[0] as String?,
      mobileno: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Addressmodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.mobileno);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
