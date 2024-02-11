// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../../../GlobalComponents/PreferenceManager.dart';
import '../../../constant.dart';
import '../PendingGRN/summeryScreen.dart';

class addNewOrderForPo extends StatefulWidget {
  addNewOrderForPo({Key? key}) : super(key: key);

  @override
  _addNewOrderForPoState createState() => _addNewOrderForPoState();
}

class _addNewOrderForPoState extends State<addNewOrderForPo> {
  int qty = 1;
  List fpricelist_Items = [];
  String dropdownValue = 'Uom';
  final List<String> dropdownValue0 = List.filled(100000, 'Carton');
  final List<TextEditingController> _controllers = [];
  bool idLoading = false;
  List ItemmasterData = [];
  List? data;
  double GST = 0.0;
  double TCS = 0.0;
  late Item item;
  List<Item> ArrayItem =[];
  double total = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double IGST = 0.0;
  double TotalAfterDiscount = 0.0;
  double Total_Other_discount_Amount = 0.0;
  double Total_Trade_discount_Amount = 0.0;
  double totalSchemeDiscountAmount = 0.0;

  var Distributor_state_code;

  var companyStateCode;

  double orderTotal = 0.0;

  List<Object?>? itmval;

  var TCS_Applicable;

  List cartArray = [];

  String selectedCetagory = '';

  List filterList = [];
  List selectionItems=[];

  TextEditingController Parent_NameController = TextEditingController();
  TextEditingController SubCategory_NameController = TextEditingController();
  openHiveBox() async {
    var box = await Hive.openBox('erpApiMainData');
    var bookmark = box.get('erpApiMainData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        debugPrint("DATA ${value[0]['gst'][0]['state_code']}");
        setState(() {
          TCS_Applicable = value[0]['TCS_Applicable'];

          Distributor_state_code = value[0]['gst'][0]['state_code'].toString();
        });
      }
    });
  }

  List offlineItem = [];
  List tempItem = [];
  openHiveBoxFORITEMSData() async {
    var box = await Hive.openBox('ItemList');
    var bookmark = box.get('ItemList');

    tempItem = bookmark;
    setState(() {});
    offlineItem = tempItem;
    offlineItem.sort((a, b) => a["Item_name"].compareTo(b["Item_name"]));
    log(offlineItem.length);
    for (int j = 0; j < bookmark.length; j++) {
      //filterList=bookmark[j]['Parent_Name'];
    }
    // log(value)
    log("??????????????????" + offlineItem.toList().toString());
  }

  @override
  void initState() {
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
      } else {
        kMainColor = Colors.red;
      }
    });
    openHiveBox();
    openHiveBoxFORfshipmasterData();
    openHiveBoxFORITEMSData();
    PreferenceManager.instance
        .getStringValue("companyStateCode")
        .then((value) => setState(() {
              companyStateCode = value;
              print(value);
            }));
   // fpricelist();
    //fshipmaster();
   // fitemmaster();
    //var box = Hive.box('erpApiMainData');
    //var box=  Hive.openBox('erpApiMainData');

    // TODO: implement initState
    super.initState();
  }

  bool ActiveConnection = false;
  String T = "";


  List<Map<String, dynamic>> cart = [];
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
  }

  String filterType = '';
  TextEditingController compneyNameController = TextEditingController();
  final GlobalKey<_addNewOrderForPoState> expansionTileKey = GlobalKey();

  var selectedWareHouse;
  @override
  Widget build(BuildContext context) {
    Set<String> uniqueValues = Set<String>();
    Set<String> uniqueValues2 = Set<String>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add New Order',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          ActiveConnection
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Image(
                    color: Colors.white,
                    height: 30,
                    width: 30,
                    image: AssetImage('images/wifi.png'),
                  ),
                ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: context.width(),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  /*  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Chikki', 'Khakhra', 'Krunchips','Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue0,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue0 = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Food Products', 'Tingels Jaljira', 'Bilas Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {
                        setState(() {});
                        offlineItem = tempItem
                            .where((item) => item["Item_name"]
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        //filterSearchResults(value,context);
                      },
                      onSubmitted: (value) {},
                      // autocorrect: true,
                    ),
                  ),
                  /*idLoading
                      ?  Center(child: CircularProgressIndicator())
                      :*/
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      // height: 65,
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      child: Theme(
                        data: ThemeData(
                          // Set the default border to zero
                          dividerColor: Colors.transparent,
                          // Optionally, you can set other properties as well
                          // dividerColor: Colors.red, // Example to set divider color
                          // dividerTheme: DividerThemeData(
                          //   color: Colors.red, // Example to set divider color
                          // ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      label: Text("Billing Address"),
                                        hintText: "Select Billing Address",
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                            Divider(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        label: Text("Category"),
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    controller: Parent_NameController,
                                    // decoration: InputDecoration(
                                  ),
                                ),
                                PopupMenuButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  onSelected: (value) {
                                    setState(() {
                                      // var selectedItem = offlineItem.firstWhere(
                                      //       (item) => item["Parent_Name"] == value,
                                      // );
                                      Parent_NameController.text =
                                          value.toString();
                                      //selectedCode = selectedItem["Select_Value_Code"];
                                      //log(selectedCode);
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    offlineItem.sort((a, b) => a["Parent_Name"].compareTo(b["Parent_Name"]));
                                    return offlineItem
                                        .where((value) => uniqueValues
                                        .add(value["Parent_Name"]))
                                        .map<PopupMenuItem>((value) {
                                      return PopupMenuItem(
                                          height: 50,
                                          value: value["Parent_Name"],
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.only(left: 8.0),
                                                child: Text(value["Parent_Name"],
                                                    style:
                                                    TextStyle(fontSize: 12)),
                                              ),
                                            ],
                                          ));
                                    }).toList();
                                  },
                                ),
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        label: Text(
                                            SubCategory_NameController.text == ""
                                                ? "Sub Category"
                                                : ""),
                                        border: InputBorder.none),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    controller: SubCategory_NameController,
                                    // decoration: InputDecoration(
                                  ),
                                ),
                                Visibility(
                                  visible: Parent_NameController.text == ""
                                      ? false
                                      : true,
                                  child: PopupMenuButton(
                                    icon: Icon(Icons.arrow_drop_down),
                                    onCanceled: () {
                                      // SubCategory_NameController.clear();
                                    },
                                    onSelected: (value) {
                                      setState(() {
                                        // var selectedItem = offlineItem.firstWhere(
                                        //       (item) => item["Parent_Name"] == value,
                                        // );

                                        if (SubCategory_NameController.text ==
                                            "") {
                                          SubCategory_NameController.text =
                                              value.toString();
                                          offlineItem = tempItem
                                              .where((item) => item[
                                          "Category_Name"]
                                              .toLowerCase()
                                              .contains(
                                              SubCategory_NameController
                                                  .text
                                                  .toLowerCase()))
                                              .toList();

                                        } else {
                                          //  SubCategory_NameController.clear();
                                          offlineItem = tempItem;
                                        }

                                        //selectedCode = selectedItem["Select_Value_Code"];
                                        //log(selectedCode);
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      offlineItem.sort((a, b) => a["Category_Name"].compareTo(b["Category_Name"]));
                                      return offlineItem
                                          .where((value) => uniqueValues2.add(
                                          Parent_NameController.text ==
                                              value["Parent_Name"]
                                              ? value["Category_Name"]
                                              : "No Data"))
                                          .map<PopupMenuItem>((value) {
                                        return PopupMenuItem(
                                            height: 50,
                                            value: value["Category_Name"],
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 8.0),
                                                  child: Text(
                                                      value["Category_Name"],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          overflow: TextOverflow
                                                              .visible)),
                                                ),
                                              ],
                                            ));
                                      }).toList();
                                    },
                                  ),
                                ),

                                InkWell(
                                    onTap: () {
                                      setState(() {});
                                      SubCategory_NameController.clear();
                                      Parent_NameController.clear();
                                      offlineItem = tempItem;
                                      offlineItem.sort((a, b) => a["Item_name"].compareTo(b["Item_name"]));
                                    },
                                    child: Icon(CupertinoIcons.delete))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: offlineItem == [] || offlineItem == null
                          ? CircularProgressIndicator()
                          : ListView.builder(

                              itemCount:
                                  offlineItem == null || offlineItem == []
                                      ? 0
                                      : offlineItem.length,
                              itemBuilder: (ctx, itemIndex) {
                                offlineItem.sort((a, b) => a["Item_name"].compareTo(b["Item_name"]));
                                // _controllers.clear();
                                for (int i = 0; i < offlineItem!.length; i++) {
                                  if (offlineItem != null) {
                                    _controllers.add(TextEditingController(
                                        /* text: fpricelist_Items[i].qty.toString() == '0'
                                        ? ''
                                        : fpricelist_Items[i].qty.toString()*/
                                        ));
                                    _controllers[i].selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                _controllers[i].text.length));
                                  }
                                }
                                return Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    // height: 65,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            ActiveConnection
                                                ? Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "https://urminstore.com/pub/media/catalog/product/cache/835e48150b5844ff4116c639e4c3d879/f/a/farali-tikha-front.jpg")),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  )
                                                : Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "images/wifi.png")),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                              offlineItem[
                                                                      itemIndex]
                                                                  ['Item_name'],
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 7, top: 5),
                                              child: Text(
                                                '\u{20B9} ${offlineItem[itemIndex]['MRP']}',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Flexible(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField(
                                                    value: dropdownValue0[
                                                        itemIndex],
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue0[itemIndex] = newValue!;
                                                       log (dropdownValue0[itemIndex]);
                                                      });
                                                    },
                                                    items: <String>[
                                                      'Carton',
                                                      'Unit'
                                                    ].map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                child: TextFormField(
                                                  controller:
                                                      _controllers[itemIndex],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    enabled: true,
                                                    border: InputBorder.none,
                                                    // enabledBorder: OutlineInputBorder(),
                                                    // labelText: 'Nos',
                                                    hintText: 'Nos',
                                                  ),
                                                  onChanged: (value) async {
                                                    String str = value;
                                                    if (value == '') {
                                                      value = '0';
                                                    }
                                                    if (value != "" ||
                                                        value != null) {
                                                      log(str.toString());
                                                      int qty = int.parse(str);
                                                      // cartArray.add(offlineItem[
                                                      //     itemIndex]);
                                                      // cart.add(offlineItem[
                                                      //     itemIndex]);
                                                      log("CartArray" +
                                                          cart.toString());
                                                      log(dropdownValue0[itemIndex]);

                                                      var scdc = offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Trade_Disc'] ==
                                                              ""
                                                          ? 0.0
                                                          : offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Trade_Disc'] ==
                                                              "";
                                                      var scmdc = offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Scheme_Disc'] ==
                                                              ""
                                                          ? 0.0
                                                          : offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Scheme_Disc'] ==
                                                              "";
                                                      var otrdc = offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Other_Disc'] ==
                                                              ""
                                                          ? 0.0
                                                          : offlineItem[
                                                                      itemIndex]
                                                                  [
                                                                  'Other_Disc'] ==
                                                              "";
                                                      double WSP = double.parse(
                                                          offlineItem[itemIndex]
                                                              ['WSP']);
                                                      double Tax_Rate =
                                                          double.parse(offlineItem[itemIndex]['Tax_Rate']);
                                                      double Unit_Per_Carton =
                                                          double.parse(offlineItem[
                                                                  itemIndex][
                                                              'Unit_Per_Carton']);
                                                      double Unit_Per_Box = double
                                                          .parse(offlineItem[
                                                                  itemIndex]
                                                              ['Unit_Per_Box']);
                                                      double Scheme_Disc =
                                                          double.parse(
                                                              scmdc.toString());
                                                      double Trade_Disc =
                                                          double.parse(
                                                              scdc.toString());
                                                      double Other_Disc =
                                                          double.parse(
                                                              otrdc.toString());
                                                      log("WSP" +
                                                          WSP.toString());
                                                      item = Item(
                                                        itemCode: offlineItem[itemIndex]['Item_id'],
                                                        UOM:dropdownValue0[itemIndex],
                                                        wspRate: WSP,
                                                        gstPer: Tax_Rate,
                                                        priceCalc: offlineItem[itemIndex]['Price_Calc'],
                                                        unitPerCarton: Unit_Per_Carton,
                                                        quantity: qty,
                                                        unitPerBox: Unit_Per_Box,
                                                        schemeDisc: Scheme_Disc,
                                                        tradeDisc: Trade_Disc,
                                                        otherDisc: Other_Disc,
                                                      );
                                                      ArrayItem.clear();
                                                      ArrayItem.add(item);

                                                      //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      //   prefs.setStringList("cartProducts", item as List<String>);
                                                      // var cartProducts= prefs.getStringList("cartProducts");
                                                      // setState(() {
                                                      //  var listItems = cartProducts;
                                                      //  log(listItems);
                                                      // });

                                                      for (int i = 0; i < ArrayItem.length; i++) {
                                                        print('Index ${[i]}');
                                                      }
                                                      log(ArrayItem[0].toString());
                                                      itmval = [
                                                        item.itemCode,
                                                        item.wspRate,
                                                        item.gstPer,
                                                        item.priceCalc,
                                                        item.unitPerCarton,
                                                        item.quantity,
                                                        item.unitPerBox,
                                                        item.schemeDisc,
                                                        item.tradeDisc,
                                                        item.otherDisc
                                                      ];

                                                      total = calculateTotal(item);
                                                      if(item.UOM.toString()=="Carton") {
                                                        totalSchemeDiscountAmount = (item
                                                                    .quantity! *
                                                                item.unitPerCarton! /
                                                                item.unitPerBox! *
                                                                item.schemeDisc!) ??
                                                            0;
                                                        Total_Trade_discount_Amount = (item
                                                                    .quantity! *
                                                                item.unitPerCarton! /
                                                                item.unitPerBox! *
                                                                item.tradeDisc!) ??
                                                            0;
                                                        Total_Other_discount_Amount = (item
                                                                    .quantity! *
                                                                item.unitPerCarton! /
                                                                item.unitPerBox! *
                                                                item.otherDisc!) ??
                                                            0;
                                                      }else{
                                                        totalSchemeDiscountAmount = (item
                                                            .quantity! *
                                                            item.unitPerCarton! /
                                                            item.unitPerBox! *
                                                            item.schemeDisc!) ??
                                                            0;
                                                        Total_Trade_discount_Amount = (item
                                                            .quantity! *
                                                            item.unitPerCarton! /
                                                            item.unitPerBox! *
                                                            item.tradeDisc!) ??
                                                            0;
                                                        Total_Other_discount_Amount = (item
                                                            .quantity! *
                                                            item.unitPerCarton! /
                                                            item.unitPerBox! *
                                                            item.otherDisc!) ??
                                                            0;
                                                      }
                                                      TotalAfterDiscount =
                                                          calculateTotalAfterDiscount(
                                                              item);

                                                      var GST1 =
                                                          calculateGstCharge(
                                                              item);
                                                      GST = double.parse(GST1
                                                          .toStringAsFixed(2));
                                                      // IGST = calculateIGSTAmount(item,item.gstPer);
                                                      // log("IGST"+IGST.toString());
                                                      // CGST = calculateCGSTAmount(item,item.gstPer);
                                                      // SGST = calculateSGSTAmount(item,item.gstPer);
                                                      log("companyStateCode ${companyStateCode} Distributor_state_code ${Distributor_state_code}");

                                                      if (companyStateCode == Distributor_state_code || (Distributor_state_code == "24" && companyStateCode == "24")) {
                                                        log("CGST---SGST");
                                                        CGST = calculateCGSTAmount(item, item.gstPer);
                                                        CGST = double.parse(CGST.toStringAsFixed(2));
                                                        SGST = calculateSGSTAmount(item, item.gstPer);
                                                        SGST = double.parse(SGST.toStringAsFixed(2));
                                                        log("CGST ${CGST}---SGST${SGST}");
                                                        TCS = calculateRowTCS(totalSchemeDiscountAmount, Total_Trade_discount_Amount, Total_Other_discount_Amount, SGST, CGST, IGST);
                                                        TCS = double.parse(
                                                            TCS.toStringAsFixed(
                                                                2));
                                                        calculateOrderTotal(
                                                            totalSchemeDiscountAmount,
                                                            Total_Trade_discount_Amount,
                                                            Total_Other_discount_Amount,
                                                            SGST,
                                                            CGST,
                                                            IGST);
                                                      } else {
                                                        log("IGST");
                                                        IGST =
                                                            calculateIGSTAmount(
                                                                item,
                                                                item.gstPer);
                                                        IGST = double.parse(IGST
                                                            .toStringAsFixed(
                                                                2));
                                                        log("IGST" +
                                                            IGST.toString());
                                                        if (TCS_Applicable ==
                                                            "Yes") {
                                                          TCS = calculateRowTCS(
                                                              totalSchemeDiscountAmount,
                                                              Total_Trade_discount_Amount,
                                                              Total_Other_discount_Amount,
                                                              SGST,
                                                              CGST,
                                                              IGST);
                                                          log("TCS" +
                                                              TCS.toString());
                                                        }
                                                        orderTotal = calculateOrderTotal(
                                                            totalSchemeDiscountAmount,
                                                            Total_Trade_discount_Amount,
                                                            Total_Other_discount_Amount,
                                                            SGST,
                                                            CGST,
                                                            IGST);
                                                        log(orderTotal);
                                                        //orderTotal= double.parse(orderTotal.toStringAsFixed(2));

                                                        //CGST = calculateCGSTAmount(item,item.gstPer);
                                                        //SGST = calculateSGSTAmount(item,item.gstPer);
                                                        //log("SGST"+SGST.toString());
                                                        //log("CGST"+CGST.toString());
                                                      }

                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                      /*FutureBuilder(
                              future: DefaultAssetBundle.of(context)
                                  .loadString('images/Results.json'),
                              builder: (context, snapshot) {
                                // Decode the JSON
                                var newData = json.decode(snapshot.data.toString());
                                return ListView.builder(
                                    itemCount: newData == null ? 0 : newData.length,
                                    itemBuilder: (ctx, itemIndex) {
                                     // _controllers.clear();
                                      for (int i = 0;
                                          i < newData!.length;
                                          i++) {
                                        if (newData != null) {
                                          _controllers.add(TextEditingController(
                                              */ /* text: fpricelist_Items[i].qty.toString() == '0'
                                        ? ''
                                        : fpricelist_Items[i].qty.toString()*/ /*
                                              ));
                                          _controllers[i].selection =
                                              TextSelection.fromPosition(TextPosition(offset: _controllers[i].text.length));
                                        }
                                      }
                                      return Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          // height: 65,
                                          margin:  EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        image:  DecorationImage(
                                                            image: NetworkImage(
                                                                "https://urminstore.com/pub/media/catalog/product/cache/835e48150b5844ff4116c639e4c3d879/f/a/farali-tikha-front.jpg")),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                             BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                               EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                    newData[itemIndex]
                                                                        [
                                                                        'it_name'],
                                                                    style:  TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                         EdgeInsets.only(
                                                            left: 10,
                                                            right: 7,
                                                            top: 5),
                                                    child: Text(
                                                      '\u{20B9} ${newData[itemIndex]['rate']}',
                                                      style:  TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                     EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                               InputDecoration
                                                                  .collapsed(
                                                                  hintText: ''),

                                                          // decoration: InputDecoration(
                                                          //   enabledBorder: OutlineInputBorder(
                                                          //     //<-- SEE HERE
                                                          //     borderSide: BorderSide(color: Colors.black,),
                                                          //   ),
                                                          //   focusedBorder: OutlineInputBorder(
                                                          //     //<-- SEE HERE
                                                          //     borderSide: BorderSide(color: Colors.black,),
                                                          //   ),
                                                          //   filled: true,
                                                          //   // fillColor: Colors.white,
                                                          // ),
                                                          // dropdownColor: Colors.white,
                                                          value: dropdownValue0,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              dropdownValue0 =
                                                                  newValue!;
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Carton',
                                                            'Unit'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style:
                                                                     TextStyle(),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                     SizedBox(
                                                      width: 5,
                                                    ),
                                                    Flexible(
                                                      child: TextFormField(
                                                        controller: _controllers[itemIndex],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                             InputDecoration(
                                                          enabled: true,
                                                          border:
                                                              InputBorder.none,
                                                          // enabledBorder: OutlineInputBorder(),
                                                          // labelText: 'Nos',
                                                          hintText: 'Nos',
                                                        ),
                                                        onChanged: (value){
                                                          String str = value;
                                                          int qty = int.parse(str);
                                                           item = Item(
                                                            itemCode: newData[itemIndex]['IT_CODE'],
                                                            wspRate: newData[itemIndex]['Wsp_rate'],
                                                            gstPer: newData[itemIndex]['GST_PER'],
                                                            priceCalc: newData[itemIndex]['Price_Calc'],
                                                            unitPerCarton: newData[itemIndex]['Unit_Per_Carton'],
                                                            quantity: qty,
                                                            unitPerBox: newData[itemIndex]['Unit_Per_Box'],
                                                            schemeDisc: 0.0,
                                                            tradeDisc:0.0,
                                                            otherDisc: 0.0,
                                                          );
                                                            itmval=[item.itemCode,item.wspRate,item.gstPer,item.priceCalc,item.unitPerCarton,item.quantity,item.unitPerBox,item.schemeDisc,item.tradeDisc,item.otherDisc];

                                                           total = calculateTotal(item);
                                                           totalSchemeDiscountAmount = (item.quantity!* item.unitPerCarton! /item.unitPerBox! * item.schemeDisc!) ?? 0;
                                                           Total_Trade_discount_Amount  = (item.quantity!* item.unitPerCarton! /item.unitPerBox! * item.tradeDisc!) ?? 0;
                                                           Total_Other_discount_Amount  = (item.quantity!* item.unitPerCarton! /item.unitPerBox! * item.otherDisc!) ?? 0;
                                                           TotalAfterDiscount= calculateTotalAfterDiscount(item);

                                                           GST = calculateGstCharge(item);
                                                          // IGST = calculateIGSTAmount(item,item.gstPer);
                                                          // log("IGST"+IGST.toString());
                                                          // CGST = calculateCGSTAmount(item,item.gstPer);
                                                          // SGST = calculateSGSTAmount(item,item.gstPer);
                                                           log("companyStateCode ${companyStateCode} Distributor_state_code ${Distributor_state_code}");

                                                           if(companyStateCode==Distributor_state_code||(Distributor_state_code=="24"&&companyStateCode=="24")){
                                                             log("CGST---SGST");
                                                             CGST = calculateCGSTAmount(item,item.gstPer);
                                                             SGST = calculateSGSTAmount(item,item.gstPer);
                                                             TCS=  calculateRowTCS(totalSchemeDiscountAmount,Total_Trade_discount_Amount,Total_Other_discount_Amount,SGST,CGST,IGST);
                                                             log("TCS"+TCS.toString());
                                                             calculateOrderTotal(totalSchemeDiscountAmount,Total_Trade_discount_Amount,Total_Other_discount_Amount,SGST,CGST,IGST);
                                                           }else{
                                                             log("IGST");
                                                             IGST = calculateIGSTAmount(item,item.gstPer);
                                                             log("IGST"+IGST.toString());
                                                             TCS=  calculateRowTCS(totalSchemeDiscountAmount,Total_Trade_discount_Amount,Total_Other_discount_Amount,SGST,CGST,IGST);
                                                             log("TCS"+TCS.toString());
                                                             orderTotal= calculateOrderTotal(totalSchemeDiscountAmount,Total_Trade_discount_Amount,Total_Other_discount_Amount,SGST,CGST,IGST);
                                                             log(orderTotal);
                                                             //CGST = calculateCGSTAmount(item,item.gstPer);
                                                             //SGST = calculateSGSTAmount(item,item.gstPer);
                                                             //log("SGST"+SGST.toString());
                                                             //log("CGST"+CGST.toString());
                                                           }
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),*/
                      ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.cart,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text('Add to cart',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ],
                            ),
                            onPressed: () {
                              /*showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  Item item = Item(
                                    itemCode: 'ac72bcee66c0630b38a71e45fde76e76',
                                    wspRate: 31.03,
                                    gstPer: 12.0,
                                    priceCalc: 'box',
                                    unitPerCarton: 6120.0,
                                    quantity: 10,
                                    unitPerBox: 60.0,
                                    schemeDisc: 0.0,
                                    tradeDisc: 0.0,
                                    otherDisc: 0.0,
                                  );
                                  double gstCharge = calculateGstCharge(item);
                                  double total = calculateTotal(item);
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: Text('Total'),
                                        title: Text(total.toString()),
                                      ),
                                      ListTile(
                                        leading: Text('GST'),
                                        title: Text(gstCharge.toString()),
                                      ),
                                      ListTile(
                                        leading: Text('Share'),
                                        title: Text('Share'),
                                      ),
                                    ],
                                  );
                                },
                              );*/
                              showSummaryDialog();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kMainColor)),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateRowTCS(totalSchemeDiscountAmount, Total_Trade_discount_Amount,
      Total_Other_discount_Amount, sgstAmount, cgstAmount, igstAmount) {
    double rowTCS = (total - totalSchemeDiscountAmount -
            Total_Trade_discount_Amount -
            Total_Other_discount_Amount +
            sgstAmount +
            cgstAmount +
            igstAmount) *
        0.001;

    return rowTCS.roundToDouble();
  }

  double calculateIGSTAmount(Item item, gstper) {
    double IGST = gstper / 100;
    log(IGST.toString());
    if(item.UOM.toString()=="Carton") {
      if (item.priceCalc == 'unit') {
      double baseAmount = ((((item.unitPerCarton! *
                      item.quantity! *
                      item.wspRate!) -
                  ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      item.schemeDisc!) -
                  ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      item.tradeDisc!) -
                  ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      item.otherDisc!)) *
              gstper!) /
          100);
      return baseAmount > 0 ? baseAmount : 0;
    } else if (item.priceCalc == 'box') {
      double baseAmount =
          (((((item.quantity! * item.unitPerCarton! / item.unitPerBox!) -
                          item.schemeDisc!) -
                      item.tradeDisc! -
                      item.otherDisc!) *
                  item.wspRate! *
                  gstper) /
              100);
      return baseAmount > 0 ? baseAmount : 0;
    } else {
      return 0;
    }}else{
      if (item.priceCalc == 'unit') {
        double baseAmount = ((((
            item.quantity! *
            item.wspRate!) -
            ((item.quantity!  / item.unitPerBox!) *
                item.schemeDisc!) +
            ((item.quantity!  / item.unitPerBox!) *
                item.tradeDisc!) +
            ((item.quantity! / item.unitPerBox!) *
                item.otherDisc!)) *
            gstper!) /
            100);
        return baseAmount > 0 ? baseAmount : 0;
      }
      else if (item.priceCalc == 'box') {
        double baseAmount = ((((
            (item.quantity!/item.unitPerBox! )* item.wspRate!) -
            ((item.quantity!  / item.unitPerBox!) *
                item.schemeDisc!) +
            ((item.quantity!  / item.unitPerBox!) *
                item.tradeDisc!) +
            ((item.quantity! / item.unitPerBox!) *
                item.otherDisc!)) *
            gstper!) /
            100);
        return baseAmount > 0 ? baseAmount : 0;
         } else {
        return 0;
      }
    }
  }

  double calculateSGSTAmount(Item item, gstper) {
    double Sgst = gstper / 2;
    if(item.UOM.toString()=="Carton") {

      if (item.priceCalc == 'unit') {
      double baseAmount = (item.unitPerCarton! *
              item.quantity! *
              item.wspRate!) -
          (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      (item.schemeDisc ?? 0) +
                  (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      (item.tradeDisc ?? 0) +
                  (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      (item.otherDisc ?? 0)) *
              Sgst /
              100);
      return baseAmount > 0 ? baseAmount : 0;
    }
      else if (item.priceCalc == 'box') {
      double baseAmount =
          (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      item.wspRate!) -
                  ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                              (item.schemeDisc ?? 0) +
                          (item.quantity! *
                                  item.unitPerCarton! /
                                  item.unitPerBox!) *
                              (item.tradeDisc ?? 0) +
                          (item.quantity! *
                                  item.unitPerCarton! /
                                  item.unitPerBox!) *
                              (item.otherDisc ?? 0)) *
                      Sgst /
                      100) ??
              0;
      return baseAmount > 0 ? baseAmount : 0;
    } else {
      return 0;
    }}else{
      if (item.priceCalc == 'unit') {
        double baseAmount = (item.unitPerCarton! *
            item.quantity! *
            item.wspRate!) -
            (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                (item.schemeDisc ?? 0) +
                (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    (item.tradeDisc ?? 0) +
                (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    (item.otherDisc ?? 0)) *
                Sgst /
                100);
        return baseAmount > 0 ? baseAmount : 0;
      }
      else if (item.priceCalc == 'box') {
        double baseAmount =
            (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                item.wspRate!) -
                ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    (item.schemeDisc ?? 0) +
                    (item.quantity! *
                        item.unitPerCarton! /
                        item.unitPerBox!) *
                        (item.tradeDisc ?? 0) +
                    (item.quantity! *
                        item.unitPerCarton! /
                        item.unitPerBox!) *
                        (item.otherDisc ?? 0)) *
                    Sgst /
                    100) ??
                0;
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

  double calculateCGSTAmount(Item item, gstper) {
    double Cgst = gstper / 2;
    log("gstper" + gstper.toString() + "Cgst" + Cgst.toString());
    if(item.UOM.toString()=="Carton") {
      if (item.priceCalc == 'unit') {
      double baseAmount = ((((item.unitPerCarton! * item.quantity! * item.wspRate!) -
          ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
              item.schemeDisc!) -
          ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
              item.tradeDisc!) -
          ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
              item.otherDisc!)) *
          item.gstPer!) /
          100);
      return baseAmount > 0 ? baseAmount : 0;
    } else if (item.priceCalc == 'box') {
      double baseAmount =
          (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                      item.wspRate!) -
                  ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                              (item.schemeDisc ?? 0) +
                          (item.quantity! *
                                  item.unitPerCarton! /
                                  item.unitPerBox!) *
                              (item.tradeDisc ?? 0) +
                          (item.quantity! *
                                  item.unitPerCarton! /
                                  item.unitPerBox!) *
                              (item.otherDisc ?? 0)) *
                      Cgst /
                      100) ??
              0;
      return baseAmount > 0 ? baseAmount : 0;
    } else {
      return 0;
    }}
    else{
      if (item.priceCalc == 'unit') {
        log (item.quantity! * item.wspRate!);
        log ((item.quantity! / item.unitPerBox!) * (item.schemeDisc ?? 0));
        double baseAmount = (item.quantity! * item.wspRate!) -
            ((((item.quantity! / item.unitPerBox!) * (item.schemeDisc ?? 0)) +
                ((item.quantity!/ item.unitPerBox!) * (item.tradeDisc ?? 0)) +
                ((item.quantity! / item.unitPerBox!) * (item.otherDisc ?? 0))) *
                (Cgst /
                100));
        return baseAmount > 0 ? baseAmount : 0;
      } else if (item.priceCalc == 'box') {
        double baseAmount =
            (((item.quantity! / item.unitPerBox!) * item.wspRate!) -
                (((item.quantity!  / item.unitPerBox!) * (item.schemeDisc ?? 0)) +
                    ((item.quantity!  / item.unitPerBox!) * (item.tradeDisc ?? 0)) +
                    ((item.quantity!  / item.unitPerBox!) * (item.otherDisc ?? 0))) *
                    (Cgst / 100)) ??
                0;
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

  double calculateTotalAfterDiscount(Item item) {
    if(item.UOM.toString()=="Carton") {
      if (item.priceCalc == 'unit') {
        double baseAmount =
            (item.unitPerCarton! * item.quantity! * item.wspRate!) -
                ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.schemeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.tradeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.otherDisc ?? 0));
        return baseAmount > 0 ? baseAmount : 0;
      } else if (item.priceCalc == 'box') {
        double baseAmount =
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    item.wspRate!) -
                ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.schemeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.tradeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.otherDisc ?? 0));
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }else{
      if (item.priceCalc == 'unit') {
        double baseAmount =
            (item.unitPerCarton! * item.quantity! * item.wspRate!) -
                ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    (item.schemeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.tradeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.otherDisc ?? 0));
        return baseAmount > 0 ? baseAmount : 0;
      } else if (item.priceCalc == 'box') {
        double baseAmount =
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                item.wspRate!) -
                ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                    (item.schemeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.tradeDisc ?? 0) +
                    (item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        (item.otherDisc ?? 0));
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

  double calculateGstCharge(Item item) {
    double gstCharge;
    if(item.UOM.toString()=="Carton") {
      if (item.priceCalc == 'unit') {
        gstCharge = ((((item.unitPerCarton! * item.quantity! * item.wspRate!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                item.schemeDisc!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                item.tradeDisc!) -
            ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                item.otherDisc!)) *
            item.gstPer!) /
            100);
      }
      else if (item.priceCalc == 'box') {
        gstCharge =
        (((((item.quantity! * item.unitPerCarton! / item.unitPerBox!) -
            item.schemeDisc!) -
            item.tradeDisc! -
            item.otherDisc!) *
            item.wspRate! *
            item.gstPer!) /
            100);
      }
      else {
        // Handle the case when priceCalc is neither 'unit' nor 'box'
        gstCharge =
        0.0; // You may want to choose a default value or handle this case differently
      }
    }else{
      if (item.priceCalc == 'unit') {
        gstCharge = ((((item.unitPerCarton! * item.wspRate!) -
            ((item.quantity! / item.unitPerBox!) *
                item.schemeDisc!) -
            ((item.quantity!  / item.unitPerBox!) *
                item.tradeDisc!) -
            ((item.quantity! / item.unitPerBox!) *
                item.otherDisc!)) *
            item.gstPer!) /
            100);
      }
      else if (item.priceCalc == 'box') {

        gstCharge = (((((item.quantity!/item.unitPerBox!) * item.wspRate!) -
            ((item.quantity! / item.unitPerBox!) *
                item.schemeDisc!) +
            ((item.quantity! / item.unitPerBox!) *
                item.tradeDisc!) +
            ((item.quantity! / item.unitPerBox!) *
                item.otherDisc!)) *
            item.gstPer!) /
            100);
      }
      else {
        // Handle the case when priceCalc is neither 'unit' nor 'box'
        gstCharge =
        0.0; // You may want to choose a default value or handle this case differently
      }
    }
    return gstCharge;
  }

  double calculateOrderTotal(
      totalSchemeDiscountAmount,
      Total_Trade_discount_Amount,
      Total_Other_discount_Amount,
      sgstAmount,
      cgstAmount,
      igstAmount) {
    double orderTotal = total -
        totalSchemeDiscountAmount -
        Total_Trade_discount_Amount -
        Total_Other_discount_Amount +
        cgstAmount +
        sgstAmount +
        igstAmount;

    return orderTotal;
  }

  /* double calculateGstCharge(Item item,TotalAfterDiscount) {
    double gstCharge;

    if (item.priceCalc == 'unit') {
      gstCharge = ((
          ((item.unitPerCarton! * item.quantity! * item.wspRate!) -
              ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.schemeDisc!) -
              ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.tradeDisc!) -
              ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.otherDisc!)) *
              item.gstPer!) /
          100);
    } else if (item.priceCalc == 'box') {
      gstCharge = ((
          (((item.quantity! * item.unitPerCarton! / item.unitPerBox!) - item.schemeDisc!) -
              item.tradeDisc! -
              item.otherDisc!) *
              item.wspRate! *
              item.gstPer!) /
          100);
    } else {
      // Handle the case when priceCalc is neither 'unit' nor 'box'
      gstCharge = 0.0; // You may want to choose a default value or handle this case differently
    }

    return gstCharge;
  }*/
  double calculateTotal(Item item) {
    double total;
    log(item.UOM.toString());
    if(item.UOM.toString()=="Carton") {
      log("Nakul");
      if (item.priceCalc == 'unit') {
        total = (item.unitPerCarton! * item.quantity! * item.wspRate!);
      } else if (item.priceCalc == 'box') {
        total = ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) * item.wspRate!);
      } else {
        total = 0.0; // You may want to choose a default value or handle this case differently
      }
    }else{
      log("Nakul..........");
      if (item.priceCalc == 'unit') {
        total = ( item.quantity! * item.wspRate!);
      } else if (item.priceCalc == 'box') {
        total = ((item.quantity!  / item.unitPerBox!) * item.wspRate!);
      } else {
        total = 0.0; // You may want to choose a default value or handle this case differently
      }
    }
    return total;
  }

  // double calculateTotal(priceCalc,unitPerCarton,quantity,wspRate,unitPerBox) {
  //   double total;
  //
  //   if (priceCalc == 'unit') {
  //     total = (unitPerCarton! * quantity! * wspRate!).roundToDouble();
  //     var totall=total;
  //     log("Total"+totall.toString());
  //   } else if (priceCalc == 'box') {
  //
  //     total = ((quantity! * unitPerCarton! / unitPerBox!) * wspRate!).roundToDouble();
  //     var totall=total;
  //     log("Total"+totall.toString());
  //   } else {
  //     total = 0.0; // You may want to choose a default value or handle this case differently
  //   }
  //
  //   return total;
  // }
  void showSummaryDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => OrderSummaryScreen(
            total.toString(),
            GST.toString(),
            CGST.toString(),
            SGST.toString(),
            IGST.toString(),
            TCS.toString(),
            orderTotal,
            itmval));
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

  Future<void> fshipmaster() async {
    setState(() {
      idLoading = true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fshipmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "dcbd62d4d5e6446634e5ba708be6e850"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading = false;
      });
      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          idLoading = false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        //debugPrint("responseBody $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fshipmaster ${body}");

        var box = Hive.box('fshipmasterData');
        box.put('fshipmasterData', body);
        await Hive.openBox('fshipmasterData');
        Map<String, dynamic> bookmark = box.get('fshipmasterData');
        bookmark.forEach((key, value) {
          if (key == 'docs') {
            debugPrint("fshipmasterData $value");
          }
        });
      } else {
        setState(() {
          idLoading = false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading = false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }

  Future<void> fpricelist() async {
    setState(() {
      idLoading = true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fpricelist/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {
        "Company_id": "1a36b22bdd89ffd361644e6ea06c2394",
        "Factory_id": "8101b2c0a710849dc04f61cc3c07cb9a",
        "Price_id": "9d22b8a2af022745b593bf1c740ed329"
      }
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading = false;
      });
      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          idLoading = false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fpricelist ${body['docs'][0]['item']}");
        fpricelist_Items = body['docs'][0]['item'];
        log("ItemCount " + fpricelist_Items.length.toString());

        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        if (mounted!) return;
        setState(() {
          idLoading = false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      if (mounted!) return;
      setState(() {
        idLoading = false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }

  Future<void> fitemmaster() async {
    setState(() {
      idLoading = true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fitemmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "limit": 5000,
      "selector": {
        "Company_id": "1a36b22bdd89ffd361644e6ea06c2394",
        "Factory_id": "8101b2c0a710849dc04f61cc3c07cb9a"
      }
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading = false;
      });
      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          idLoading = false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        //body['docs'][0]['Item_name']
        ItemmasterData = body['docs'];
        log(ItemmasterData.toString());
        for (int k = 0; k < ItemmasterData.length; k++) {
          for (int j = 0; j < fpricelist_Items.length; j++) {}
          //  debugPrint("responseBody fitemmaster ${body['docs'][k]['Status']}");
        }
        //fpricelist_Items=body['docs'][0]['item'];
        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading = false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading = false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
}

// class ITMMData {
//   List<Map<String, dynamic>> data = [
//     {
//       'itemCode': 'Image1',
//       'it_name': '\$ 120',
//       'amount': 'Headphone',
//     },
//   ];
// }

class Item {
  String? itemCode;
  String? it_name;
  String? UOM;
  String? NCC_Duty;
  double? wspRate;
  double? gstPer;
  String? priceCalc;
  double? unitPerCarton;
  double? Weight_Per_Carton;
  double? Weight_Per_Unit;
  dynamic HSN_CODE;
  double? Freight_Amt;
  double? Std_Amt;
  int? quantity;
  double? unitPerBox;
  double? schemeDisc;
  double? tradeDisc;
  double? otherDisc;
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
    this.Std_Amt,
    this.Freight_Amt,
    this.Weight_Per_Unit,
    this.Weight_Per_Carton,
    this.quantity,
    this.unitPerBox,
    this.schemeDisc,
    this.tradeDisc,
    this.otherDisc,
    this.cgst,
  });
}

