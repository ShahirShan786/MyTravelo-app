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
      activities: (fields[5] as Map).cast<String, List<String>>(),
      time: fields[6] as String,
      userId: fields[7] as String,
      companion: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(8) // Total number of fields
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

class CompletedTripModelBlogAdapter
    extends TypeAdapter<CompletedTripModelBlog> {
  @override
  final int typeId = 4;

  @override
  CompletedTripModelBlog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTripModelBlog(
      blog: fields[0] as String,
      id: fields[1] as String,
      tripId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTripModelBlog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.blog)
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
      other is CompletedTripModelBlogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FevoriteModelAdapter extends TypeAdapter<FevoriteModel> {
  @override
  final int typeId = 5;

  @override
  FevoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FevoriteModel(
      id: fields[0] as String,
      fevoritePlace: fields[1] as String,
      userId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FevoriteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fevoritePlace)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FevoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 6;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      id: fields[0] as String,
      tripId: fields[1] as String,
      amount: fields[2] as String,
      discription: fields[3] as String?,
      category: fields[4] as String,
      image: fields[5] as String,
      color: Color(fields[6] as int), // Convert the stored int back to Color
      date: fields[7] != null ? fields[7] as DateTime : null, // Handle nullable DateTime
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(8) // Update to the new number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tripId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.discription)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.color.value) // Convert Color to int and store it
      ..writeByte(7)
      ..write(obj.date); // Write DateTime (nullable field handled correctly)
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}


class DreamDestinationModelAdapter extends TypeAdapter<DreamDestinationModel> {
  @override
  final int typeId = 7;

  @override
  DreamDestinationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DreamDestinationModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      destination: fields[2] as String,
      totalExpense: fields[3] as double,
      totalSavings: fields[4] as double,
      placeImage: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DreamDestinationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.destination)
      ..writeByte(3)
      ..write(obj.totalExpense)
      ..writeByte(4)
      ..write(obj.totalSavings)
      ..writeByte(5)
      ..write(obj.placeImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DreamDestinationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

