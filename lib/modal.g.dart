// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransectionAdapter extends TypeAdapter<Transection> {
  @override
  final int typeId = 0;

  @override
  Transection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transection();
  }

  @override
  void write(BinaryWriter writer, Transection obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
