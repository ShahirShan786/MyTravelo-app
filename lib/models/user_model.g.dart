// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 2;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      destination: fields[0] as String,
      rangeStart: fields[1] as DateTime,
      rangeEnd: fields[2] as DateTime,
      id: fields[3] as String,
      companion: (fields[4] as List).cast<Contact>(),
      activities: (fields[5] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.destination)
      ..writeByte(1)
      ..write(obj.rangeStart)
      ..writeByte(2)
      ..write(obj.rangeEnd)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.companion)
      ..writeByte(5)
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
