// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'erpApiMainDataResponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ErpApiMainDataResponseAdapter
    extends TypeAdapter<ErpApiMainDataResponse> {
  @override
  final int typeId = 0;

  @override
  ErpApiMainDataResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ErpApiMainDataResponse(
      docs: (fields[0] as List).cast<Doc>(),
      bookmark: fields[1] as String,
      warning: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ErpApiMainDataResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.docs)
      ..writeByte(1)
      ..write(obj.bookmark)
      ..writeByte(2)
      ..write(obj.warning);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErpApiMainDataResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
