class ErpApiMainDataResponse {
  List<Doc> docs;
  String bookmark;
  String warning;

  ErpApiMainDataResponse({
    required this.docs,
    required this.bookmark,
    required this.warning,
  });
}

class Doc {
  String id;
  String rev;
  String distributorId;
  String companyName;
  String name;
  String rsmId;
  String sfaId;
  String mobileNo;
  String companyId;
  String factoryId;
  String businessId;
  String emailId;
  String address;
  String pinCode;
  String city;
  String state;
  List<Gst> gst;
  String schemeDisc;
  String tradeDisc;
  String stdAmt;
  String distCat;
  String tcsApplicable;
  String status;
  String roleRights;
  String priceId;

  Doc({
    required this.id,
    required this.rev,
    required this.distributorId,
    required this.companyName,
    required this.name,
    required this.rsmId,
    required this.sfaId,
    required this.mobileNo,
    required this.companyId,
    required this.factoryId,
    required this.businessId,
    required this.emailId,
    required this.address,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.gst,
    required this.schemeDisc,
    required this.tradeDisc,
    required this.stdAmt,
    required this.distCat,
    required this.tcsApplicable,
    required this.status,
    required this.roleRights,
    required this.priceId,
  });

}

class Gst {
  String date;
  String endDate;
  String gstNumber;
  String panNumber;
  String recDate;
  String stateCode;

  Gst({
    required this.date,
    required this.endDate,
    required this.gstNumber,
    required this.panNumber,
    required this.recDate,
    required this.stateCode,
  });

}
