// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Itemlistresponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NamkeenItemAdapter extends TypeAdapter<NamkeenItem> {
  @override
  final int typeId = 3;

  @override
  NamkeenItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NamkeenItem(
      itemId: fields[0] as String,
      itemName: fields[1] as String,
      hsn: fields[2] as String,
      mrp: fields[3] as double,
      wsp: fields[4] as double,
      schemeDisc: fields[5] as double,
      tradeDisc: fields[6] as double,
      freightAmt: fields[7] as double,
      stdAmt: fields[8] as double,
      otherDisc: fields[9] as double,
      nccDuty: fields[10] as double,
      parentName: fields[11] as String,
      priceCalc: fields[12] as String,
      categoryName: fields[13] as String,
      taxRate: fields[14] as double,
      itemWeight: fields[15] as double,
      weightPerUnit: fields[16] as double,
      unitPerBox: fields[17] as int,
      unitPerCarton: fields[18] as int,
      weightPerCarton: fields[19] as double,
      freeQtyBox: fields[20] as String,
      packaging: fields[21] as String,
      freightCalc: fields[22] as String,
      shelfLife: fields[23] as String,
      status: fields[24] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NamkeenItem obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.hsn)
      ..writeByte(3)
      ..write(obj.mrp)
      ..writeByte(4)
      ..write(obj.wsp)
      ..writeByte(5)
      ..write(obj.schemeDisc)
      ..writeByte(6)
      ..write(obj.tradeDisc)
      ..writeByte(7)
      ..write(obj.freightAmt)
      ..writeByte(8)
      ..write(obj.stdAmt)
      ..writeByte(9)
      ..write(obj.otherDisc)
      ..writeByte(10)
      ..write(obj.nccDuty)
      ..writeByte(11)
      ..write(obj.parentName)
      ..writeByte(12)
      ..write(obj.priceCalc)
      ..writeByte(13)
      ..write(obj.categoryName)
      ..writeByte(14)
      ..write(obj.taxRate)
      ..writeByte(15)
      ..write(obj.itemWeight)
      ..writeByte(16)
      ..write(obj.weightPerUnit)
      ..writeByte(17)
      ..write(obj.unitPerBox)
      ..writeByte(18)
      ..write(obj.unitPerCarton)
      ..writeByte(19)
      ..write(obj.weightPerCarton)
      ..writeByte(20)
      ..write(obj.freeQtyBox)
      ..writeByte(21)
      ..write(obj.packaging)
      ..writeByte(22)
      ..write(obj.freightCalc)
      ..writeByte(23)
      ..write(obj.shelfLife)
      ..writeByte(24)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamkeenItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
