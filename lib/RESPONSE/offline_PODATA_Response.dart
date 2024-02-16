// To parse this JSON data, do
//
//     final purchaseOrder = purchaseOrderFromJson(jsonString);

import 'dart:convert';

List<PurchaseOrder> purchaseOrderFromJson(String str) => List<PurchaseOrder>.from(json.decode(str).map((x) => PurchaseOrder.fromJson(x)));

String purchaseOrderToJson(List<PurchaseOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseOrder {
  String coCode;
  String urCode;
  String factoryId;
  String businessId;
  DateTime curDate;
  DateTime curTime;
  String urnNo;
  String billingAddress;
  String srNo;
  String remarksDealer;
  String remarksRsm;
  String poStatus;
  String fyear;
  String roundOff;
  String orderTotal;
  String reason;
  String shippingAddress;
  String poApprovalDate;
  String erpUrn;
  String doNo;
  String doDate;
  List<Item> item;

  PurchaseOrder({
    required this.coCode,
    required this.urCode,
    required this.factoryId,
    required this.businessId,
    required this.curDate,
    required this.curTime,
    required this.urnNo,
    required this.billingAddress,
    required this.srNo,
    required this.remarksDealer,
    required this.remarksRsm,
    required this.poStatus,
    required this.fyear,
    required this.roundOff,
    required this.orderTotal,
    required this.reason,
    required this.shippingAddress,
    required this.poApprovalDate,
    required this.erpUrn,
    required this.doNo,
    required this.doDate,
    required this.item,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
    coCode: json["CO_CODE"],
    urCode: json["UR_CODE"],
    factoryId: json["Factory_id"],
    businessId: json["business_id"],
    curDate: DateTime.parse(json["cur_date"]),
    curTime: DateTime.parse(json["cur_time"]),
    urnNo: json["URN_NO"],
    billingAddress: json["billing_address"],
    srNo: json["SR_NO"],
    remarksDealer: json["Remarks_dealer"],
    remarksRsm: json["Remarks_rsm"],
    poStatus: json["PO_Status"],
    fyear: json["Fyear"],
    roundOff: json["Round_Off"],
    orderTotal: json["Order_Total"],
    reason: json["Reason"],
    shippingAddress: json["shipping_address"],
    poApprovalDate: json["PO_approval_date"],
    erpUrn: json["ERP_URN"],
    doNo: json["DO_NO"],
    doDate: json["Do_Date"],
    item: List<Item>.from(json["Item"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CO_CODE": coCode,
    "UR_CODE": urCode,
    "Factory_id": factoryId,
    "business_id": businessId,
    "cur_date": "${curDate.year.toString().padLeft(4, '0')}-${curDate.month.toString().padLeft(2, '0')}-${curDate.day.toString().padLeft(2, '0')}",
    "cur_time": curTime.toIso8601String(),
    "URN_NO": urnNo,
    "billing_address": billingAddress,
    "SR_NO": srNo,
    "Remarks_dealer": remarksDealer,
    "Remarks_rsm": remarksRsm,
    "PO_Status": poStatus,
    "Fyear": fyear,
    "Round_Off": roundOff,
    "Order_Total": orderTotal,
    "Reason": reason,
    "shipping_address": shippingAddress,
    "PO_approval_date": poApprovalDate,
    "ERP_URN": erpUrn,
    "DO_NO": doNo,
    "Do_Date": doDate,
    "Item": List<dynamic>.from(item.map((x) => x.toJson())),
  };
}

class Item {
  String coCode;
  String urCode;
  DateTime curDate;
  DateTime curTime;
  String urnNo;
  String itCode;
  String itName;
  String rate;
  String uom;
  String quantity;
  String total;
  String wspRate;
  String gstPer;
  String gstCharge;
  String unitPerBox;
  String unitPerCarton;
  String weightPerUnit;
  String weightPerCarton;
  String cartonQuantity;
  String boxQuantity;
  String unitQuantity;
  String priceCalc;
  String cartonWeight;
  String unitWeight;
  String cgst;
  String sgst;
  String igst;
  String schemeDiscount;
  String tradeDisc;
  String otherDisc;
  String cgstAmount;
  String sgstAmount;
  String igstAmount;
  String totalSchemeDiscountAmount;
  String totalTradeDiscountAmount;
  String totalOtherDiscountAmount;
  String tcs;
  String hsnCode;
  String freightAmt;
  String stdAmt;
  String nccDuty;
  String totalAfterDiscount;

  Item({
    required this.coCode,
    required this.urCode,
    required this.curDate,
    required this.curTime,
    required this.urnNo,
    required this.itCode,
    required this.itName,
    required this.rate,
    required this.uom,
    required this.quantity,
    required this.total,
    required this.wspRate,
    required this.gstPer,
    required this.gstCharge,
    required this.unitPerBox,
    required this.unitPerCarton,
    required this.weightPerUnit,
    required this.weightPerCarton,
    required this.cartonQuantity,
    required this.boxQuantity,
    required this.unitQuantity,
    required this.priceCalc,
    required this.cartonWeight,
    required this.unitWeight,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.schemeDiscount,
    required this.tradeDisc,
    required this.otherDisc,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.totalSchemeDiscountAmount,
    required this.totalTradeDiscountAmount,
    required this.totalOtherDiscountAmount,
    required this.tcs,
    required this.hsnCode,
    required this.freightAmt,
    required this.stdAmt,
    required this.nccDuty,
    required this.totalAfterDiscount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    coCode: json["CO_CODE"],
    urCode: json["UR_CODE"],
    curDate: DateTime.parse(json["cur_date"]),
    curTime: DateTime.parse(json["cur_time"]),
    urnNo: json["URN_NO"].toString(),
    itCode: json["IT_CODE"].toString(),
    itName: json["it_name"].toString(),
    rate: json["rate"].toString(),
    uom: json["UOM"],
    quantity: json["quantity"],
    total: json["total"],
    wspRate: json["Wsp_rate"],
    gstPer: json["GST_PER"],
    gstCharge: json["GST_Charge"],
    unitPerBox: json["Unit_Per_Box"],
    unitPerCarton: json["Unit_Per_Carton"],
    weightPerUnit: json["Weight_Per_Unit"],
    weightPerCarton: json["Weight_Per_Carton"],
    cartonQuantity: json["Carton_quantity"],
    boxQuantity: json["Box_quantity"],
    unitQuantity: json["Unit_quantity"],
    priceCalc: json["Price_Calc"],
    cartonWeight: json["Carton_weight"],
    unitWeight: json["Unit_weight"],
    cgst: json["CGST"],
    sgst: json["SGST"],
    igst: json["IGST"],
    schemeDiscount: json["Scheme_discount"],
    tradeDisc: json["Trade_Disc"],
    otherDisc: json["Other_Disc"],
    cgstAmount: json["CGST_Amount"],
    sgstAmount: json["SGST_Amount"],
    igstAmount: json["IGST_Amount"],
    totalSchemeDiscountAmount: json["Total_scheme_discount_Amount"],
    totalTradeDiscountAmount: json["Total_Trade_discount_Amount"],
    totalOtherDiscountAmount: json["Total_Other_discount_Amount"],
    tcs: json["TCS"],
    hsnCode: json["HSN_CODE"],
    freightAmt: json["Freight_Amt"],
    stdAmt: json["Std_Amt"],
    nccDuty: json["NCC_Duty"],
    totalAfterDiscount: json["total_after_discount"],
  );

  Map<String, dynamic> toJson() => {
    "CO_CODE": coCode,
    "UR_CODE": urCode,
    "cur_date": "${curDate.year.toString().padLeft(4, '0')}-${curDate.month.toString().padLeft(2, '0')}-${curDate.day.toString().padLeft(2, '0')}",
    "cur_time": curTime.toIso8601String(),
    "URN_NO": urnNo,
    "IT_CODE": itCode,
    "it_name": itName,
    "rate": rate,
    "UOM": uom,
    "quantity": quantity,
    "total": total,
    "Wsp_rate": wspRate,
    "GST_PER": gstPer,
    "GST_Charge": gstCharge,
    "Unit_Per_Box": unitPerBox,
    "Unit_Per_Carton": unitPerCarton,
    "Weight_Per_Unit": weightPerUnit,
    "Weight_Per_Carton": weightPerCarton,
    "Carton_quantity": cartonQuantity,
    "Box_quantity": boxQuantity,
    "Unit_quantity": unitQuantity,
    "Price_Calc": priceCalc,
    "Carton_weight": cartonWeight,
    "Unit_weight": unitWeight,
    "CGST": cgst,
    "SGST": sgst,
    "IGST": igst,
    "Scheme_discount": schemeDiscount,
    "Trade_Disc": tradeDisc,
    "Other_Disc": otherDisc,
    "CGST_Amount": cgstAmount,
    "SGST_Amount": sgstAmount,
    "IGST_Amount": igstAmount,
    "Total_scheme_discount_Amount": totalSchemeDiscountAmount,
    "Total_Trade_discount_Amount": totalTradeDiscountAmount,
    "Total_Other_discount_Amount": totalOtherDiscountAmount,
    "TCS": tcs,
    "HSN_CODE": hsnCode,
    "Freight_Amt": freightAmt,
    "Std_Amt": stdAmt,
    "NCC_Duty": nccDuty,
    "total_after_discount": totalAfterDiscount,
  };
}
