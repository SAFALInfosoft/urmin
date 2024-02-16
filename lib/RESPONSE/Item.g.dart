// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 6;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      itemCode: fields[0] as String?,
      it_name: fields[1] as String?,
      UOM: fields[2] as String?,
      NCC_Duty: fields[3] as String?,
      wspRate: fields[4] as double?,
      gstPer: fields[5] as double?,
      priceCalc: fields[6] as String?,
      HSN_CODE: fields[10] as dynamic,
      unitPerCarton: fields[7] as double?,
      Weight_Per_Carton: fields[8] as double?,
      Weight_Per_Unit: fields[9] as double?,
      Freight_Amt: fields[11] as double?,
      Std_Amt: fields[12] as double?,
      quantity: fields[13] as int?,
      unitPerBox: fields[14] as double?,
      schemeDisc: fields[15] as double?,
      tradeDisc: fields[16] as double?,
      otherDisc: fields[17] as double?,
      cgst: fields[18] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.itemCode)
      ..writeByte(1)
      ..write(obj.it_name)
      ..writeByte(2)
      ..write(obj.UOM)
      ..writeByte(3)
      ..write(obj.NCC_Duty)
      ..writeByte(4)
      ..write(obj.wspRate)
      ..writeByte(5)
      ..write(obj.gstPer)
      ..writeByte(6)
      ..write(obj.priceCalc)
      ..writeByte(7)
      ..write(obj.unitPerCarton)
      ..writeByte(8)
      ..write(obj.Weight_Per_Carton)
      ..writeByte(9)
      ..write(obj.Weight_Per_Unit)
      ..writeByte(10)
      ..write(obj.HSN_CODE)
      ..writeByte(11)
      ..write(obj.Freight_Amt)
      ..writeByte(12)
      ..write(obj.Std_Amt)
      ..writeByte(13)
      ..write(obj.quantity)
      ..writeByte(14)
      ..write(obj.unitPerBox)
      ..writeByte(15)
      ..write(obj.schemeDisc)
      ..writeByte(16)
      ..write(obj.tradeDisc)
      ..writeByte(17)
      ..write(obj.otherDisc)
      ..writeByte(18)
      ..write(obj.cgst);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
