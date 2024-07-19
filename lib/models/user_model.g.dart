// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 1;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      destination: fields[0] as String?,
      date: fields[1] as DateTime?,
      rangeStart: fields[2] as DateTime,
      rangeEnd: fields[3] as DateTime,
      uId: fields[4] as String?,
      companion: fields[5] as String?,
      activities: (fields[6] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.destination)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.rangeStart)
      ..writeByte(3)
      ..write(obj.rangeEnd)
      ..writeByte(4)
      ..write(obj.uId)
      ..writeByte(5)
      ..write(obj.companion)
      ..writeByte(6)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
