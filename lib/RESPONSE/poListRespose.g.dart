// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poListRespose.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseOrderAdapter extends TypeAdapter<PurchaseOrder> {
  @override
  final int typeId = 4;

  @override
  PurchaseOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseOrder(
      urnNo: fields[0] as String,
      poStatus: fields[1] as String,
      currentDate: fields[2] as String,
      total: fields[3] as double,
      box: fields[4] as double,
      finalTotal: fields[5] as double,
      totalWeight: fields[6] as double,
      totalQuantity: fields[7] as double,
      itemQuantity: fields[8] as int,
      dispatchCity: fields[9] as String,
      totalTax: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseOrder obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.urnNo)
      ..writeByte(1)
      ..write(obj.poStatus)
      ..writeByte(2)
      ..write(obj.currentDate)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.box)
      ..writeByte(5)
      ..write(obj.finalTotal)
      ..writeByte(6)
      ..write(obj.totalWeight)
      ..writeByte(7)
      ..write(obj.totalQuantity)
      ..writeByte(8)
      ..write(obj.itemQuantity)
      ..writeByte(9)
      ..write(obj.dispatchCity)
      ..writeByte(10)
      ..write(obj.totalTax);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PurchaseOrderListAdapter extends TypeAdapter<PurchaseOrderList> {
  @override
  final int typeId = 4;

  @override
  PurchaseOrderList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseOrderList(
      message: (fields[0] as List).cast<PurchaseOrder>(),
      draftCount: fields[1] as int,
      rsmApprovalCount: fields[2] as int,
      completedCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseOrderList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.draftCount)
      ..writeByte(2)
      ..write(obj.rsmApprovalCount)
      ..writeByte(3)
      ..write(obj.completedCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseOrderListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
