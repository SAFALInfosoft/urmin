import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../GlobalComponents/PreferenceManager.dart';
import '../../../GlobalComponents/button_global.dart';
import '../../../constant.dart';
import 'PO/RSM_Order_Approval_Main_Screen.dart';




class SummaryScreen extends StatefulWidget {
  // final OrderDetailsListData data;
  // final String? routeName;
  // final Function(String) onSubmitCallBack;
  // final Function onCancelCallBack;
  String total;
  String gstCharge,CGST,SGST,IGST,TCS;
  double orderTotal;
  var item; double temp_roundoff;double totalofScemeDiscount; var LocalFieldString;
  SummaryScreen( this.total, this.gstCharge,this.CGST,this.SGST,this.IGST,this.TCS,this.orderTotal,this.item,this.temp_roundoff,this.totalofScemeDiscount,this.LocalFieldString,

      {Key? key,

        /* required this.data,
        required this.routeName,
        required this.onSubmitCallBack*/
        /*required this.onCancelCallBack*/})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SummaryScreen> {
  String summary = '';
  String purpose = 'Address';
  bool selection = false;
  List<String> selected = [];

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  bool isVisible = false;bool isVisible1 = true;

  var DayType="Full Day";

  var roundoff;
  List selectionItems=[];

  var selectedWareHouse;
  List<String>? existingData;

  int grandTotal=0;

  double roundOff=0.0;

  String? companyStateCode,TCS_Applicable,Distributor_state_code;

  openHiveBox() async {
    var box = await Hive.openBox('erpApiMainData');
    var bookmark = box.get('erpApiMainData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        debugPrint("DATA ${value[0]['gst'][0]['state_code']+companyStateCode}");
        setState(() {
          TCS_Applicable = value[0]['TCS_Applicable'];
          Distributor_state_code = value[0]['gst'][0]['state_code'].toString();
        });
      }
    });
  }
  openHiveBoxFORfshipmasterData() async {
    var box = await Hive.openBox('fshipmasterData');
    var bookmark = box.get('fshipmasterData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        debugPrint("DATA ${value[0]}");
        selectionItems = value;
        print("selectionItems.length "+selectionItems.length.toString());
        if (selectionItems.length == 1) {
          compneyNameController.text = selectionItems[0]['Warehouse_Name'];
          selectedWareHouse=selectionItems[0]['Warehouse_id'];
          // selectedCode = selectionItems[0]['Select_Value_Code'];
        }
        log(selectionItems);
        // setState(() {
        //   Distributor_state_code=value[0]['gst'][0]['state_code'].toString();
        // });
      }
    });
  }
  TextEditingController compneyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    log("FieldString"+widget.item.toString());
    PreferenceManager.instance
        .getStringValue("companyStateCode")
        .then((value) => setState(() {
      companyStateCode = value;
      print(value);
    }));
    //openHiveBoxFORfshipmasterData();
    //openHiveBox();
    log((widget.item.length));
//     for (var i = 0; i < widget.item.length; i++) {
// log(i.toString());
//     }
    grandTotal = (widget.total.toDouble() + widget.gstCharge.toDouble()).ceil();
    print(grandTotal); // Output: 354397

    // Calculate the round-off value
    roundOff = (grandTotal - widget.total.toDouble() - widget.gstCharge.toDouble());
    print(roundOff); // Output: 0.28 (Note: Dart does not remove trailing zeros)

    double orderTotal= double.parse(widget.orderTotal.toStringAsFixed(2));

    log(orderTotal.toString());
    var roundoff1=orderTotal-orderTotal.toInt();
    // roundoff=roundoff1.toStringAsFixed(2);
    //var round=calculateroundOFF();
    // var roundOFF= calculateroundOFF();
    //  log(round.toString());
  }
  double calculateroundOFF() {
    double orderTotalDouble = double.parse("${widget.orderTotal}");
    // int orderTotalInt = int.parse("${widget.orderTotal}");
    //   log(orderTotalInt);
    double roundOFF = orderTotalDouble;
    return roundOFF.roundToDouble();
  }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title:  Text('Order Summary'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      actions: <Widget>[
        SizedBox(height: 20.0),
        Row(
          children: [
            Flexible(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding:  EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                      color: Color(0xFF555555),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child:  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'poppins_regular'),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  // widget.onCancelCallBack();
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding:  EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child:  Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'poppins_regular'),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () =>
                {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                    log(widget.LocalFieldString);
                    Map<String, dynamic> dataList = jsonDecode(widget.LocalFieldString);
                    var data = dataList;

                    // Modify the value for Remarks_dealer
                    log(summary);
                    data['Remarks_dealer'] = "$summary"??"";
                    // Convert the modified data back to JSON string
                    String modifiedJsonString = jsonEncode(dataList);
                    log(modifiedJsonString);
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    existingData = prefs.getStringList("POLISTJSON") ?? [];
                    // bool timeExists = existingData!.contains([{"CO_CODE":"1a36b22bdd89ffd361644e6ea06c2394", "UR_CODE":"50c60cdef1e5286ef69f0256ab03c577", "Factory_id":"8101b2c0a710849dc04f61cc3c07cb9a", "business_id":"", "cur_date":"", "cur_time":"", "URN_NO":1, "billing_address":"null", "SR_NO":"", "Remarks_dealer": "", "Remarks_rsm":"", "PO_Status":"RSM_Approval", "Fyear":"2023-2024", "Round_Off":"0.40486", "Order_Total":"3548.40486", "Reason":"", "shipping_address":"null", "PO_approval_date":"", "ERP_URN":"", "DO_NO":"", "Do_Date":"","Item": [{"CO_CODE":"1a36b22bdd89ffd361644e6ea06c2394", "UR_CODE":"50c60cdef1e5286ef69f0256ab03c577", "cur_date":"", "cur_time":"","URN_NO":"","IT_CODE": "0b51ad7a885d3218329fada00f5618b4", "it_name":"BAGHBAN BILAS REFRESH 1.8 GMS POUCH50+10FREE =60 POUCH", "rate":50.0, "UOM": "Carton", "quantity": 1, "total":3165.06, "Wsp_rate": 31.03, "GST_PER": 12.0, "GST_Charge": 189.9,"Unit_Per_Box": 60.0, "Unit_Per_Carton": 6120.0, "Weight_Per_Unit": 1.8,"Weight_Per_Carton": 13.77, "Carton_quantity": "", "Box_quantity": "", "Unit_quantity": "", "Price_Calc": box, "Carton_weight": 200819, "Unit_weight": "", "CGST": "6.0", "SGST": "6.0", "IGST": "12.0", "Scheme_discount": 0.0, "Trade_Disc": 0.0, "Other_Disc": 0.0, "CGST_Amount": 189.9, "SGST_Amount": 189.9, "IGST_Amount": 0.0, "Total_scheme_discount_Amount": 0.0, "Total_Trade_discount_Amount": 0.0, "Total_Other_discount_Amount": 0.0, "TCS":"3.5448600000000003", "HSN_CODE": 200819, "Freight_Amt": 0.0, "Std_Amt": 0.0, "NCC_Duty": 0, "total_after_discount": 3165.06 }]}]);
                    // log(timeExists);
                    // Add new entry (current time) to the existing data
                    existingData!.add(modifiedJsonString);

                    // Save the modified data back to SharedPreferences
                    prefs.setStringList("POLISTJSON", existingData!);
                    print(existingData!.length.toString());
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>RSMOrderApprovalMainScreen()));
                    Fluttertoast.showToast(
                        msg: "Successfully PO added to cart",
                        textColor: Colors.white,
                        backgroundColor: Colors.green,
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG);
                  })
                },
              ),
            ),
          ],
        )
      ],
      content: SingleChildScrollView(
        physics:  ClampingScrollPhysics(),
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children:  <Widget>[
                        Text('Total Of WSP'),
                        widget.totalofScemeDiscount!=0.00?SizedBox(
                          height: 5.0,
                        ):SizedBox.shrink(),
                        widget.totalofScemeDiscount!=0.00?Text('Scheme Discount'):SizedBox.shrink(),
                        SizedBox(
                          height: 5.0,
                        ),
                        (companyStateCode != Distributor_state_code) || (Distributor_state_code != "24" && companyStateCode != "24")? Text('IGST'):SizedBox.shrink(),
                        (companyStateCode != Distributor_state_code) || (Distributor_state_code != "24" && companyStateCode != "24")?SizedBox(
                          height: 5.0,
                        ):SizedBox.shrink(),
                        SizedBox(
                          height: 5.0,
                        ),
                        (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")? Text('CGST'):SizedBox.shrink(),
                        (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")?SizedBox(
                          height: 5.0,
                        ):SizedBox.shrink(),
                        SizedBox(
                          height: 5.0,
                        ),
                        (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")? Text('SGST'):SizedBox.shrink(),
                        (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")?SizedBox(
                          height: 5.0,
                        ):SizedBox.shrink(),
                        Text('TOTAL GST'),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                            'TCS'),SizedBox(
                          height: 5.0,
                        ),
                        Text(
                            'Roundoff'),SizedBox(
                          height: 5.0,
                        ),
                        Text(
                            'Order Total'),

                        // Text('Sub Total'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children:  <Widget>[
                      Text('  \u{20B9}${widget.total.toDouble().toStringAsFixed(2)}',style: TextStyle(overflow: TextOverflow.ellipsis)),
                      widget.totalofScemeDiscount!=0.00? SizedBox(
                        height: 5.0,
                      ):SizedBox.shrink(),
                      widget.totalofScemeDiscount!=0.00?Text('  \u{20B9}${widget.totalofScemeDiscount.toDouble().toStringAsFixed(2)}',style: TextStyle(overflow: TextOverflow.ellipsis)):SizedBox.shrink(),
                      SizedBox(
                        height: 5.0,
                      ),
                      (companyStateCode != Distributor_state_code) || (Distributor_state_code != "24" && companyStateCode != "24")?Text('  \u{20B9}${widget.IGST.toDouble().toStringAsFixed(2)}',style: TextStyle(overflow: TextOverflow.ellipsis)):SizedBox.shrink(),
                      (companyStateCode != Distributor_state_code) || (Distributor_state_code != "24" && companyStateCode != "24")?SizedBox(
                        height: 5.0,
                      ):SizedBox.shrink(),
                      SizedBox(
                        height: 5.0,
                      ),
                      (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")? Text('  \u{20B9}${widget.CGST.toDouble().toStringAsFixed(2)}',style: TextStyle(overflow: TextOverflow.ellipsis)):SizedBox.shrink(),
                      (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")?SizedBox(
                        height: 5.0,
                      ):SizedBox.shrink(),
                      SizedBox(
                        height: 5.0,
                      ),
                      (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")? Text('  \u{20B9}${widget.SGST.toDouble().toStringAsFixed(2)}',style: TextStyle(overflow: TextOverflow.ellipsis)):SizedBox.shrink(),
                      (companyStateCode == Distributor_state_code) || (Distributor_state_code == "24" && companyStateCode == "24")?SizedBox(
                        height: 5.0,
                      ):SizedBox.shrink(),
                      Text('  \u{20B9}${widget.gstCharge.toDouble().toStringAsFixed(2)}'),
                      SizedBox(
                          height: 5.0
                      ),
                      Text('  \u{20B9}${widget.TCS.toDouble().toStringAsFixed(2)}'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('  \u{20B9}${widget.temp_roundoff.toDouble().toStringAsFixed(2)}'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('  \u{20B9}${widget.orderTotal.roundToDouble()}',style: TextStyle(overflow: TextOverflow.ellipsis)),


                    ],
                  ),
                ],
              ),
              Divider(),
              /*Align(
                        alignment: Alignment.center,
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                              image: AssetImage(
                                'images/empty.png',
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Order item list not found",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "poppins_regular",
                            fontWeight: FontWeight.w900,
                            fontSize: 17.0),
                      )
                    ],
                        ),
                      ),*/

              //  Divider(),
              // ConstrainedBox(
              //   constraints: BoxConstraints(
              //     maxHeight: MediaQuery.of(context).size.height * 0.4,
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                  Text(
              //                   "Order ID        :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                  SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.orderNo".toString(),
              //                   style:  TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                  Text(
              //                   "Order date   :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                  SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.orderDate".toString(),
              //                   style:  TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                  Text(
              //                   "Shop Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                  SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.party".toString(),
              //                   style:  TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                  Text(
              //                   "Party Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                  SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                  " widget.data.shopName".toString(),
              //                   style:  TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                  Text(
              //                   "Route Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                  SizedBox(
              //                   width: 10,
              //                 ),
              //                 Flexible(
              //                   child: Text(
              //                     "widget.routeName".toString(),
              //                     overflow: TextOverflow.visible,
              //
              //                     style:  TextStyle(
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.w500,
              //                       fontSize: 14.0,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Visibility(
              //               visible: false,
              //               child: Padding(
              //                 padding:  EdgeInsets.only(
              //                     left: 20, right: 20, top: 5, bottom: 10),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                      Text(
              //                       "URN NO        :",
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w600,
              //                         fontSize: 14.0,
              //                       ),
              //                     ),
              //                      SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                      " widget.data.uRNNo".toString(),
              //                       style:  TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 14.0,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child:/* widget.data != null
              //             ? buildOrderDueDataListing(context,*//* widget.data*//*)
              //             : */Align(
              //           alignment: Alignment.center,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children:  [
              //               SizedBox(
              //                   height: 100,
              //                   width: 100,
              //                   child: Image(
              //                       image: AssetImage(
              //                         'images/empty.png',
              //                       ))),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 "Order item list not found",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontFamily: "poppins_regular",
              //                     fontWeight: FontWeight.w900,
              //                     fontSize: 17.0),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                // height: context.height(),
                //padding:  EdgeInsets.all(20.0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                                label: Text("Shipping Address"),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                            style:  TextStyle(fontSize: 15, color: Colors.black),
                            controller: compneyNameController,
                            // decoration: InputDecoration(
                          ),
                        ),
                        selectionItems.length > 1?
                        PopupMenuButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onSelected: (value) {
                            setState(() {
                              var selectedItem = selectionItems.firstWhere((item) => item["Warehouse_Name"] == value
                              );
                              compneyNameController.text =
                                  value.toString();
                              selectedWareHouse =
                              selectedItem["Warehouse_id"];
                              log(selectedWareHouse);
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return selectionItems
                                .map<PopupMenuItem>((value) {
                              return PopupMenuItem(
                                  height: 50,
                                  value: value['Warehouse_Name'],
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            value['Warehouse_Name'],
                                            style:
                                            TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ));
                            }).toList();
                          },
                        ):Container(),
                      ],
                    ),
                    /*AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      decoration:  InputDecoration(
                        labelText: 'Payment Reference number',
                        // hintText: '543223',
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 60.0,
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        readOnly: true,
                        enabled: true,
                        decoration: InputDecoration(
                          labelText: 'Choose File',
                          hintText: 'No File Chosen',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          prefixIcon: Image.asset('images/choosefile.png'),
                          border:  OutlineInputBorder(),
                        ),
                      ),
                    ),*/

                    // ButtonGlobal(
                    //   buttontext: 'Save',
                    //   buttonDecoration:
                    //   kButtonDecoration.copyWith(color: kMainColor),
                    //   onPressed: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  afterCheckinMainPage(),));
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                autofocus: false,
                maxLines: 2,
                onChanged: (value) {
                  summary = value;
                  setState(() {});
                },
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),],
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
                decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Add Remarks",

                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey)),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

/*  Widget buildOrderDueDataListing(
      BuildContext context,
      *//*OrderDetailsListData data,*//*
      ) {
    return ListView.builder(
        physics:  ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: *//*data.items != null ? data.items?.length :*//* 0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin:
               EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: customMenuItem(data.items![index]));
        });
  }

  Widget customMenuItem(*//*OrderDetailsItem data*//*) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              data.itemName.toString(),
              style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Text(
                'Quantity :',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
               SizedBox(
                width: 5,
              ),
              Text(
                data.qty.toString(),
                style:  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
           SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Text(
                'Rate :',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
               SizedBox(
                width: 5,
              ),
              Text(
                data.rate.toString(),
                style:  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
           SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text(
                'Amount :',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
               SizedBox(
                width: 5,
              ),
              Text(
                data.amount.toString(),
                style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }*/
}
