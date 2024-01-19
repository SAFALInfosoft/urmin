// import 'package:hive/hive.dart';
//
//
// @HiveType(typeId: 0)
// class ErpApiMainDataResponse {
//   @HiveField(0)
//   List<Doc> docs;
//   @HiveField(1)
//   String bookmark;
//   @HiveField(2)
//   String warning;
//
//   ErpApiMainDataResponse({
//     required this.docs,
//     required this.bookmark,
//     required this.warning,
//   });
// }
//
// @HiveType(typeId: 1)
// class Doc {
//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   String rev;
//   @HiveField(2)
//   String distributorId;
//   @HiveField(3)
//   String companyName;
//   @HiveField(4)
//   String name;
//   @HiveField(5)
//   String rsmId;
//   @HiveField(6)
//   String sfaId;
//   @HiveField(7)
//   String mobileNo;
//   @HiveField(8)
//   String companyId;
//   @HiveField(9)
//   String factoryId;
//   @HiveField(10)
//   String businessId;
//   @HiveField(11)
//   String emailId;
//   @HiveField(12)
//   String address;
//   @HiveField(13)
//   String pinCode;
//   @HiveField(14)
//   String city;
//   @HiveField(15)
//   String state;
//   @HiveField(16)
//   List<Gst> gst;
//   @HiveField(17)
//   String schemeDisc;
//   @HiveField(18)
//   String tradeDisc;
//   @HiveField(19)
//   String stdAmt;
//   @HiveField(20)
//   String distCat;
//   @HiveField(21)
//   String tcsApplicable;
//   @HiveField(22)
//   String status;
//   @HiveField(23)
//   String roleRights;
//   @HiveField(24)
//   String priceId;
//
//   Doc({
//     required this.id,
//     required this.rev,
//     required this.distributorId,
//     required this.companyName,
//     required this.name,
//     required this.rsmId,
//     required this.sfaId,
//     required this.mobileNo,
//     required this.companyId,
//     required this.factoryId,
//     required this.businessId,
//     required this.emailId,
//     required this.address,
//     required this.pinCode,
//     required this.city,
//     required this.state,
//     required this.gst,
//     required this.schemeDisc,
//     required this.tradeDisc,
//     required this.stdAmt,
//     required this.distCat,
//     required this.tcsApplicable,
//     required this.status,
//     required this.roleRights,
//     required this.priceId,
//   });
// }
//
// @HiveType(typeId: 2)
// class Gst {
//   @HiveField(0)
//   String date;
//   @HiveField(1)
//   String endDate;
//   @HiveField(2)
//   String gstNumber;
//   @HiveField(3)
//   String panNumber;
//   @HiveField(4)
//   String recDate;
//   @HiveField(5)
//   String stateCode;
//
//   Gst({
//     required this.date,
//     required this.endDate,
//     required this.gstNumber,
//     required this.panNumber,
//     required this.recDate,
//     required this.stateCode,
//   });
// }
