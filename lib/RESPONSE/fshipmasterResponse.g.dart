// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fshipmasterResponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class fshipmasterResponseAdapter extends TypeAdapter<fshipmasterResponse> {
  @override
  final int typeId = 1;

  @override
  fshipmasterResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return fshipmasterResponse(
      id: fields[0] as String,
      rev: fields[1] as String,
      companyId: fields[2] as String,
      businessId: fields[3] as String,
      factoryId: fields[4] as String,
      distributorId: fields[5] as String,
      warehouseId: fields[6] as String,
      warehouseName: fields[7] as String,
      warehouseAddress1: fields[8] as String,
      warehouseAddress2: fields[9] as String,
      warehouseAddress3: fields[10] as String,
      warehouseCity: fields[11] as String,
      warehousePincode: fields[12] as String,
      warehouseDistrict: fields[13] as String,
      warehouseState: fields[14] as String,
      warehouseCountry: fields[15] as String,
      status: fields[16] as int,
      billing: fields[17] as int,
    );
  }

  @override
  void write(BinaryWriter writer, fshipmasterResponse obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rev)
      ..writeByte(2)
      ..write(obj.companyId)
      ..writeByte(3)
      ..write(obj.businessId)
      ..writeByte(4)
      ..write(obj.factoryId)
      ..writeByte(5)
      ..write(obj.distributorId)
      ..writeByte(6)
      ..write(obj.warehouseId)
      ..writeByte(7)
      ..write(obj.warehouseName)
      ..writeByte(8)
      ..write(obj.warehouseAddress1)
      ..writeByte(9)
      ..write(obj.warehouseAddress2)
      ..writeByte(10)
      ..write(obj.warehouseAddress3)
      ..writeByte(11)
      ..write(obj.warehouseCity)
      ..writeByte(12)
      ..write(obj.warehousePincode)
      ..writeByte(13)
      ..write(obj.warehouseDistrict)
      ..writeByte(14)
      ..write(obj.warehouseState)
      ..writeByte(15)
      ..write(obj.warehouseCountry)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.billing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is fshipmasterResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
