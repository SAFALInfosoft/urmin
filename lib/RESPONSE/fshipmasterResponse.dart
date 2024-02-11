import 'package:hive/hive.dart';
part 'fshipmasterResponse.g.dart';


@HiveType(typeId: 0) // Add type ID, should be unique
class fshipmasterResponse {
  @HiveField(0)
  String id;

  @HiveField(1)
  String rev;

  @HiveField(2)
  String companyId;

  @HiveField(3)
  String businessId;

  @HiveField(4)
  String factoryId;

  @HiveField(5)
  String distributorId;

  @HiveField(6)
  String warehouseId;

  @HiveField(7)
  String warehouseName;

  @HiveField(8)
  String warehouseAddress1;

  @HiveField(9)
  String warehouseAddress2;

  @HiveField(10)
  String warehouseAddress3;

  @HiveField(11)
  String warehouseCity;

  @HiveField(12)
  String warehousePincode;

  @HiveField(13)
  String warehouseDistrict;

  @HiveField(14)
  String warehouseState;

  @HiveField(15)
  String warehouseCountry;

  @HiveField(16)
  int status;

  @HiveField(17)
  int billing;

  fshipmasterResponse({
    required this.id,
    required this.rev,
    required this.companyId,
    required this.businessId,
    required this.factoryId,
    required this.distributorId,
    required this.warehouseId,
    required this.warehouseName,
    required this.warehouseAddress1,
    required this.warehouseAddress2,
    required this.warehouseAddress3,
    required this.warehouseCity,
    required this.warehousePincode,
    required this.warehouseDistrict,
    required this.warehouseState,
    required this.warehouseCountry,
    required this.status,
    required this.billing,
  });
}
