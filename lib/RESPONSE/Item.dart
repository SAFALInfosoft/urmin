import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 6)
class Item extends HiveObject {
  @HiveField(0)
  String? itemCode;
  @HiveField(1)
  String? it_name;
  @HiveField(2)
  String? UOM;
  @HiveField(3)
  String? NCC_Duty;
  @HiveField(4)
  double? wspRate;
  @HiveField(5)
  double? gstPer;
  @HiveField(6)
  String? priceCalc;
  @HiveField(7)
  double? unitPerCarton;
  @HiveField(8)
  double? Weight_Per_Carton;
  @HiveField(9)
  double? Weight_Per_Unit;
  @HiveField(10)
  dynamic HSN_CODE;
  @HiveField(11)
  double? Freight_Amt;
  @HiveField(12)
  double? Std_Amt;
  @HiveField(13)
  int? quantity;
  @HiveField(14)
  double? unitPerBox;
  @HiveField(15)
  double? schemeDisc;
  @HiveField(16)
  double? tradeDisc;
  @HiveField(17)
  double? otherDisc;
  @HiveField(18)
  int? cgst;

  Item({
    this.itemCode,
    this.it_name,
    this.UOM,
    this.NCC_Duty,
    this.wspRate,
    this.gstPer,
    this.priceCalc,
    this.HSN_CODE,
    this.unitPerCarton,
    this.Weight_Per_Carton,
    this.Weight_Per_Unit,
    this.Freight_Amt,
    this.Std_Amt,
    this.quantity,
    this.unitPerBox,
    this.schemeDisc,
    this.tradeDisc,
    this.otherDisc,
    this.cgst,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemCode': itemCode,
      'it_name': it_name,
      'UOM': UOM,
      'NCC_Duty': NCC_Duty,
      'wspRate': wspRate,
      'gstPer': gstPer,
      'priceCalc': priceCalc,
      'HSN_CODE': HSN_CODE,
      'unitPerCarton': unitPerCarton,
      'Weight_Per_Carton': Weight_Per_Carton,
      'Weight_Per_Unit': Weight_Per_Unit,
      'Freight_Amt': Freight_Amt,
      'Std_Amt': Std_Amt,
      'quantity': quantity,
      'unitPerBox': unitPerBox,
      'schemeDisc': schemeDisc,
      'tradeDisc': tradeDisc,
      'otherDisc': otherDisc,
      'cgst': cgst,
    };
  }

  @override
  String toString() {
    return "Item(itemCode: $itemCode, it_name: $it_name, UOM: $UOM, NCC_Duty: $NCC_Duty, wspRate: $wspRate, gstPer: $gstPer, priceCalc: $priceCalc, HSN_CODE: $HSN_CODE, unitPerCarton: $unitPerCarton, Weight_Per_Carton: $Weight_Per_Carton, Weight_Per_Unit: $Weight_Per_Unit, Freight_Amt: $Freight_Amt, Std_Amt: $Std_Amt, quantity: $quantity, unitPerBox: $unitPerBox, schemeDisc: $schemeDisc, tradeDisc: $tradeDisc, otherDisc: $otherDisc, cgst: $cgst)";
  }
}
