// To parse this JSON data, do
//
//     final poDataResponse = poDataResponseFromJson(jsonString);

import 'dart:convert';

PoDataResponse poDataResponseFromJson(String str) => PoDataResponse.fromJson(json.decode(str));

String poDataResponseToJson(PoDataResponse data) => json.encode(data.toJson());

class PoDataResponse {
  Settings settings;
  List<Message> message;
  String netAmount;
  String gstAmount;
  String roundOff;
  String cgstAmount;
  String sgstAmount;
  String igstAmount;
  String totalSchemeDiscountAmount;
  String totalTradeDiscountAmount;
  String totalOtherDiscountAmount;
  String orderTotal;
  List<CartItem> cartItems;
  String tds;
  String shippingAddress;
  String billingAddress;
  String remarksDealer;
  String catonTotal;
  String boxTotal;
  String unitTotal;
  String vosTotal;
  String reason;
  String rsmRemarks;

  PoDataResponse({
    required this.settings,
    required this.message,
    required this.netAmount,
    required this.gstAmount,
    required this.roundOff,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.totalSchemeDiscountAmount,
    required this.totalTradeDiscountAmount,
    required this.totalOtherDiscountAmount,
    required this.orderTotal,
    required this.cartItems,
    required this.tds,
    required this.shippingAddress,
    required this.billingAddress,
    required this.remarksDealer,
    required this.catonTotal,
    required this.boxTotal,
    required this.unitTotal,
    required this.vosTotal,
    required this.reason,
    required this.rsmRemarks,
  });

  factory PoDataResponse.fromJson(Map<String, dynamic> json) => PoDataResponse(
    settings: Settings.fromJson(json["settings"]),
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    netAmount: json["Net_amount"],
    gstAmount: json["GST_Amount"],
    roundOff: json["Round_off"],
    cgstAmount: json["CGST_Amount"],
    sgstAmount: json["SGST_Amount"],
    igstAmount: json["IGST_Amount"],
    totalSchemeDiscountAmount: json["Total_scheme_discount_Amount"],
    totalTradeDiscountAmount: json["Total_Trade_discount_Amount"],
    totalOtherDiscountAmount: json["Total_Other_discount_Amount"],
    orderTotal: json["Order_total"],
    cartItems: List<CartItem>.from(json["Cart_Items"].map((x) => CartItem.fromJson(x))),
    tds: json["TDS"],
    shippingAddress: json["Shipping_address"],
    billingAddress: json["Billing_address"],
    remarksDealer: json["Remarks_dealer"],
    catonTotal: json["Caton_total"],
    boxTotal: json["box_total"],
    unitTotal: json["Unit_total"],
    vosTotal: json["VOS_total"],
    reason: json["Reason"],
    rsmRemarks: json["RSM_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "settings": settings.toJson(),
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
    "Net_amount": netAmount,
    "GST_Amount": gstAmount,
    "Round_off": roundOff,
    "CGST_Amount": cgstAmount,
    "SGST_Amount": sgstAmount,
    "IGST_Amount": igstAmount,
    "Total_scheme_discount_Amount": totalSchemeDiscountAmount,
    "Total_Trade_discount_Amount": totalTradeDiscountAmount,
    "Total_Other_discount_Amount": totalOtherDiscountAmount,
    "Order_total": orderTotal,
    "Cart_Items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
    "TDS": tds,
    "Shipping_address": shippingAddress,
    "Billing_address": billingAddress,
    "Remarks_dealer": remarksDealer,
    "Caton_total": catonTotal,
    "box_total": boxTotal,
    "Unit_total": unitTotal,
    "VOS_total": vosTotal,
    "Reason": reason,
    "RSM_remarks": rsmRemarks,
  };
}

class CartItem {
  String itCode;
  String itemName;
  double wspRate;
  int gstPer;
  String priceCalc;
  String uom;
  int quantity;
  int box;
  int cartonQuantity;
  int unitQuantity;
  double gstAmount;
  double total;
  String cartonWeight;

  CartItem({
    required this.itCode,
    required this.itemName,
    required this.wspRate,
    required this.gstPer,
    required this.priceCalc,
    required this.uom,
    required this.quantity,
    required this.box,
    required this.cartonQuantity,
    required this.unitQuantity,
    required this.gstAmount,
    required this.total,
    required this.cartonWeight,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itCode: json["IT_Code"],
    itemName: json["Item_Name"],
    wspRate: json["Wsp_rate"]?.toDouble(),
    gstPer: json["GST_PER"],
    priceCalc: json["Price_Calc"],
    uom: json["UOM"],
    quantity: json["Quantity"],
    box: json["box"],
    cartonQuantity: json["Carton_quantity"],
    unitQuantity: json["Unit_quantity"],
    gstAmount: json["GST_Amount"]?.toDouble(),
    total: json["Total"]?.toDouble(),
    cartonWeight: json["carton_weight"],
  );

  Map<String, dynamic> toJson() => {
    "IT_Code": itCode,
    "Item_Name": itemName,
    "Wsp_rate": wspRate,
    "GST_PER": gstPer,
    "Price_Calc": priceCalc,
    "UOM": uom,
    "Quantity": quantity,
    "box": box,
    "Carton_quantity": cartonQuantity,
    "Unit_quantity": unitQuantity,
    "GST_Amount": gstAmount,
    "Total": total,
    "carton_weight": cartonWeight,
  };
}

class Message {
  String urnNo;

  Message({
    required this.urnNo,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    urnNo: json["URN_No"],
  );

  Map<String, dynamic> toJson() => {
    "URN_No": urnNo,
  };
}

class Settings {
  String success;

  Settings({
    required this.success,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
