// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singInModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SinginmodelAdapter extends TypeAdapter<Singinmodel> {
  @override
  final int typeId = 1;

  @override
  Singinmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Singinmodel(
      username: fields[0] as String?,
      password: fields[1] as String?,
      id: fields[2] as String?,
      email: fields[4] as String?,
      phone: fields[5] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Singinmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SinginmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
