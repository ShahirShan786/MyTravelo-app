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
      companion: (fields[4] as List).cast<String>(),
      activities: (fields[5] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      time: fields[6] as String,
      userId: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.activities)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.userId);
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

class CompletedTripModelPhotosAdapter
    extends TypeAdapter<CompletedTripModelPhotos> {
  @override
  final int typeId = 3;

  @override
  CompletedTripModelPhotos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTripModelPhotos(
      photos: fields[0] as String,
      id: fields[1] as String,
      tripId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTripModelPhotos obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.photos)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.tripId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedTripModelPhotosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
