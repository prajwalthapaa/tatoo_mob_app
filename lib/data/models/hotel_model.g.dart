// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'hotel_model.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class HotelModelAdapter extends TypeAdapter<HotelModel> {
//   @override
//   final int typeId = 0;
//
//   @override
//   HotelModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return HotelModel(
//       id: fields[0] as String,
//       name: fields[1] as String,
//       description: fields[2] as String,
//       image: fields[3] as String,
//       isFavorite: fields[4] as bool,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, HotelModel obj) {
//     writer
//       ..writeByte(5)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.description)
//       ..writeByte(3)
//       ..write(obj.image)
//       ..writeByte(4)
//       ..write(obj.isFavorite);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is HotelModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
//       id: json['id'] as String,
//       name: json['name'] as String,
//       description: json['description'] as String,
//       image: json['image'] as String,
//       isFavorite: json['isFavorite'] as bool? ?? false,
//     );
//
// Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//       'description': instance.description,
//       'image': instance.image,
//       'isFavorite': instance.isFavorite,
//     };
