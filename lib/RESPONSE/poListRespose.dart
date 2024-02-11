import 'package:hive/hive.dart';
part 'poListRespose.g.dart';

// This is the generated file by Hive

@HiveType(typeId: 4)
class PurchaseOrder {
  @HiveField(0)
  String urnNo;

  @HiveField(1)
  String poStatus;

  @HiveField(2)
  String currentDate;

  @HiveField(3)
  double total;

  @HiveField(4)
  double box;

  @HiveField(5)
  double finalTotal;

  @HiveField(6)
  double totalWeight;

  @HiveField(7)
  double totalQuantity;

  @HiveField(8)
  int itemQuantity;

  @HiveField(9)
  String dispatchCity;

  @HiveField(10)
  double totalTax;

  PurchaseOrder({
    required this.urnNo,
    required this.poStatus,
    required this.currentDate,
    required this.total,
    required this.box,
    required this.finalTotal,
    required this.totalWeight,
    required this.totalQuantity,
    required this.itemQuantity,
    required this.dispatchCity,
    required this.totalTax,
  });
}

@HiveType(typeId: 4)
class PurchaseOrderList {
  @HiveField(0)
  List<PurchaseOrder> message;

  @HiveField(1)
  int draftCount;

  @HiveField(2)
  int rsmApprovalCount;

  @HiveField(3)
  int completedCount;

  PurchaseOrderList({
    required this.message,
    required this.draftCount,
    required this.rsmApprovalCount,
    required this.completedCount,
  });
}
