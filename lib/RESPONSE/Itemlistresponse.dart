import 'package:hive/hive.dart';
part 'Itemlistresponse.g.dart';
// This is the generated file by Hive

@HiveType(typeId: 3)
class NamkeenItem {
  @HiveField(0)
  String itemId;

  @HiveField(1)
  String itemName;

  @HiveField(2)
  String hsn;

  @HiveField(3)
  double mrp;

  @HiveField(4)
  double wsp;

  @HiveField(5)
  double schemeDisc;

  @HiveField(6)
  double tradeDisc;

  @HiveField(7)
  double freightAmt;

  @HiveField(8)
  double stdAmt;

  @HiveField(9)
  double otherDisc;

  @HiveField(10)
  double nccDuty;

  @HiveField(11)
  String parentName;

  @HiveField(12)
  String priceCalc;

  @HiveField(13)
  String categoryName;

  @HiveField(14)
  double taxRate;

  @HiveField(15)
  double itemWeight;

  @HiveField(16)
  double weightPerUnit;

  @HiveField(17)
  int unitPerBox;

  @HiveField(18)
  int unitPerCarton;

  @HiveField(19)
  double weightPerCarton;

  @HiveField(20)
  String freeQtyBox;

  @HiveField(21)
  String packaging;

  @HiveField(22)
  String freightCalc;

  @HiveField(23)
  String shelfLife;

  @HiveField(24)
  int status;

  NamkeenItem({
    required this.itemId,
    required this.itemName,
    required this.hsn,
    required this.mrp,
    required this.wsp,
    required this.schemeDisc,
    required this.tradeDisc,
    required this.freightAmt,
    required this.stdAmt,
    required this.otherDisc,
    required this.nccDuty,
    required this.parentName,
    required this.priceCalc,
    required this.categoryName,
    required this.taxRate,
    required this.itemWeight,
    required this.weightPerUnit,
    required this.unitPerBox,
    required this.unitPerCarton,
    required this.weightPerCarton,
    required this.freeQtyBox,
    required this.packaging,
    required this.freightCalc,
    required this.shelfLife,
    required this.status,
  });
}
