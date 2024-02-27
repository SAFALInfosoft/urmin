// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';
import 'dart:core';
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
import 'package:intl/intl.dart';

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
  List<Item> ArrayItem = [];
  double total = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double IGST = 0.0;
  double TotalAfterDiscount = 0.0;
  double Total_Other_discount_Amount = 0.0;
  double Total_Trade_discount_Amount = 0.0;
  double totalSchemeDiscountAmount = 0.0;
  double Carton_weight = 0.0;
  double unit_weight = 0.0;

  var Distributor_state_code;

  var companyStateCode;

  double orderTotal = 0.0;

  List<dynamic?> itmval = [];

  var TCS_Applicable;

  List cartArray = [];

  String selectedCetagory = '';

  List filterList = [];
  List selectionItems = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController Parent_NameController = TextEditingController();
  TextEditingController SubCategory_NameController = TextEditingController();

  List<Item> itemList = [];

  String FieldString="";

  String? companyId, factoryId;

  var UR_CODE;

  Box? box;

  double UnitWeight=0.0;
  double CartonWeight=0.0;
  double unitQantity=0.0;
  double cartonQantity=0.0;
  double boxQantity=0.0;

  int selectedTile = -1;

  List<String> ? existingData;

  String? role;

  int? urnNO;

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

  var list;
  String formattedDate="";
  String formattedDateTime="";
  @override
  void initState() {
    urnNO = new DateTime.now().millisecondsSinceEpoch;
    DateTime now = DateTime.now();

     formattedDate = DateFormat('yyyy-MM-dd').format(now);
     formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(now);
    print(formattedDate);
     box = Hive.box('PO_OfflineJson');
     Hive.openBox('PO_OfflineJson');
     var List=box!.get('PO_OfflineJson');
     log("POLISTJSON ${List}");
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
      } else {
        kMainColor = Colors.red;
      }
    });
    openHiveBox();
    PreferenceManager.instance
        .getStringValue("factoryId")
        .then((value) => setState(() {
              factoryId = value;
              print("factoryId" + value);
            }));
    PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) => setState(() {
              companyId = value;
              print("companyId" + value);
            }));
    openHiveBoxFORfshipmasterData();
    openHiveBoxFORITEMSData();
    PreferenceManager.instance
        .getStringValue("distributorId")
        .then((value) => setState(() {
              UR_CODE = value;
              print("companyId" + value);
            }));PreferenceManager.instance
        .getStringValue("role")
        .then((value) => setState(() {
      role = value;
              print("role" + value);
            }));

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
          kMainColor = Color(0xFF2957a4);
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        kMainColor = Colors.red;
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
    CheckUserConnection();

    Set<String> uniqueValues = Set<String>();
    Set<String> uniqueValues2 = Set<String>();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
leading: Icon(CupertinoIcons.cart),
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
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    // height: 65,
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 8),
                    child: ListTile(
                      leading: Icon(CupertinoIcons.cart),
                      title: Text("Cart Items ${itemList.length==0?"":itemList.length}"),
                    ),
                  )
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                          color: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                      // height: 65,
                      margin: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 8),
                        child: Theme(
                          data: ThemeData().copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(

                            key: Key(selectedTile.toString()), //attention
                            initiallyExpanded: index == selectedTile,

                            onExpansionChanged: ((newState){
                                if(newState)
                                  setState(() {
                                    Duration(seconds:  20000);
                                    selectedTile = index;
                                  });
                                else setState(() {
                                  selectedTile = -1;
                                });
                              }),
                            title: Text("${itemList[index].it_name.toString()} (QTY: ${itemList[index].quantity.toString()})"),
                            children: [
                              Divider(),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("QTY: "+itemList[index].quantity.toString()),
                              Text("UOM: "+itemList[index].UOM.toString()),
                            ],
                          ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("WSP: "+itemList[index].wspRate.toString()),
                                  Text("VALUE OF SUPPLY: "+itemList[index].total.toStringAsFixed(2).toString(),overflow: TextOverflow.ellipsis,),
                                ],
                              ), Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("CARTON: "+itemList[index].cartonQantity.toString()),
                                  Text("BOX: "+itemList[index].boxQantity.toString(),overflow: TextOverflow.ellipsis,),
                                ],
                              ), Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("UNIT: "+itemList[index].unitQantity.toString()),
                                  Text("WEIGHT: ${itemList[index].CartonWeight!/1000} KG"/*+itemList[index].Weight_Per_Carton.toString()*/,overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                              ],
                          ),
                        ),
                      )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {
                        _controllers.clear();
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
                            SizedBox(
                              height: 3,
                            ),
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
                                selectionItems.length > 1
                                    ? PopupMenuButton(
                                        icon: Icon(Icons.arrow_drop_down),
                                        onSelected: (value) {
                                          setState(() {
                                            var selectedItem = selectionItems
                                                .firstWhere((item) =>
                                                    item["Warehouse_Name"] ==
                                                    value);
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
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Text(
                                                          value[
                                                              'Warehouse_Name'],
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                    ),
                                                  ],
                                                ));
                                          }).toList();
                                        },
                                      )
                                    : Container(),
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
                                    offlineItem.sort((a, b) => a["Parent_Name"]
                                        .compareTo(b["Parent_Name"]));
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
                                                child: Text(
                                                    value["Parent_Name"],
                                                    style: TextStyle(
                                                        fontSize: 12)),
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
                                            SubCategory_NameController.text ==
                                                    ""
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
                                        _controllers.clear();
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
                                      offlineItem.sort((a, b) =>
                                          a["Category_Name"]
                                              .compareTo(b["Category_Name"]));
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
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
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
                                      offlineItem.sort((a, b) => a["Item_name"]
                                          .compareTo(b["Item_name"]));
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
                                                                "http://docs.urmingroup.co.in/images/${offlineItem[itemIndex]['Item_code']}.jpg"),onError: (exception, stackTrace) {
                                                                  Icon(Icons.signal_cellular_connected_no_internet_0_bar);
                                                                },),
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
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 7, top: 5),
                                                  child: Text(
                                                    '\u{20B9}${offlineItem[itemIndex]['MRP']}',
                                                    style: TextStyle(fontSize: 15,color: Colors.green),
                                                  ),
                                                ), Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 7, top: 5),
                                                  child: Text(
                                                    '\u{20B9}${offlineItem[itemIndex]['WSP']}',
                                                    style: TextStyle(fontSize: 15,color: kMainColor),
                                                  ),
                                                ), Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 7, top: 5),
                                                  child: Text(
                                                    'Per ${
                                                      offlineItem[itemIndex]
                                                              ['Price_Calc']
                                                          .toUpperCase()
                                                    }',
                                                    style: TextStyle(fontSize: 15,color: Colors.red),
                                                  ),
                                                ),
                                              ],
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
                                                      _controllers[itemIndex]
                                                          .clear();
                                                      setState(() {
                                                        dropdownValue0[
                                                                itemIndex] =
                                                            newValue!;
                                                        log(dropdownValue0[
                                                            itemIndex]);
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
                                                      print('removed!! ${itemList.map((e) => e.UOM)}');
                                                      print('removed 11 !! ${itemList.map((e) => e.quantity)}');
                                                      itemList.removeWhere((element) =>
                                                          (element.itemCode == offlineItem[itemIndex]["Item_id"]) &&
                                                          (element.UOM == dropdownValue0[itemIndex]));
                                                      print('removed!! ${itemList.map((e) => e.UOM)}');
                                                      print('removed 11 !! ${itemList.map((e) => e.quantity)}');
                                                      log("FieldString" + FieldString.toString() + "itemList langth" + itemList.length.toString());
                                                      log("itemList langth" + itemList.length.toString());
                                                    }
                                                    if (value.isNotEmpty) {
                                                        log(str.toString());
                                                        int qty = int.parse(value);
                                                        var scdc = offlineItem[itemIndex]['Trade_Disc'] == "" ? 0.0
                                                            : offlineItem[itemIndex]['Trade_Disc'];
                                                        var scmdc = offlineItem[itemIndex]['Scheme_Disc'] == "" ? 0.0
                                                            : offlineItem[itemIndex]['Scheme_Disc'];
                                                        var otrdc = offlineItem[itemIndex]['Other_Disc'] == "" ? 0.0
                                                            : offlineItem[itemIndex]['Other_Disc'];
                                                        double WSP = double.parse(offlineItem[itemIndex]['WSP']);
                                                        double Tax_Rate =
                                                        double.parse(offlineItem[itemIndex]['Tax_Rate']);
                                                        double Unit_Per_Carton =
                                                        double.parse(offlineItem[itemIndex]['Unit_Per_Carton']);
                                                        double Unit_Per_Box = double.parse(offlineItem[itemIndex]['Unit_Per_Box']);
                                                        double Scheme_Disc = double.parse(scmdc.toString());
                                                        double Trade_Disc = double.parse(scdc.toString());
                                                        double Other_Disc = double.parse(otrdc.toString());
                                                        double Weight_Per_Carton = double.parse(offlineItem[itemIndex]['Weight_Per_Carton'].toString());
                                                        double MRP = double.parse(offlineItem[itemIndex]['MRP'].toString());
                                                        double Weight_Per_Unit = double.parse(offlineItem[itemIndex]['Weight_Per_Unit'].toString());
                                                        log("WSP" + WSP.toString());
                                                        Item item = Item(
                                                          itemCode: offlineItem[
                                                          itemIndex]
                                                          ['Item_id'],
                                                          it_name: offlineItem[
                                                          itemIndex]
                                                          ['Item_name'],
                                                          UOM: dropdownValue0[
                                                          itemIndex],
                                                          rate: MRP,
                                                          wspRate: WSP,
                                                          gstPer: Tax_Rate,
                                                          priceCalc: offlineItem[
                                                          itemIndex]
                                                          ['Price_Calc'],
                                                          unitPerCarton:
                                                          Unit_Per_Carton,
                                                          Weight_Per_Carton:
                                                          Weight_Per_Carton,
                                                          Weight_Per_Unit:
                                                          Weight_Per_Unit,
                                                          quantity: qty,
                                                          HSN_CODE: offlineItem[
                                                          itemIndex]['HSN'],
                                                          unitPerBox:
                                                          Unit_Per_Box,
                                                          schemeDisc: Scheme_Disc,
                                                          tradeDisc: Trade_Disc,
                                                          otherDisc: Other_Disc,
                                                          total: total,
                                                          totalSchemeDiscountAmount:
                                                          totalSchemeDiscountAmount,
                                                          Total_Trade_discount_Amount:
                                                          Total_Trade_discount_Amount,
                                                          Total_Other_discount_Amount:
                                                          Total_Other_discount_Amount,
                                                          TotalAfterDiscount:
                                                          TotalAfterDiscount,
                                                          GST: GST,
                                                          SGST: SGST,
                                                          IGST: IGST,
                                                          CGST: CGST,
                                                          TCS: TCS,
                                                          UnitWeight:UnitWeight,
                                                          CartonWeight:CartonWeight,
                                                            boxQantity:boxQantity,
                                                            cartonQantity:cartonQantity,
                                                            unitQantity:unitQantity
                                                        );

                                                        total = calculateTotal(item);
                                                       unitQantity = calculateUnitQuantity(item);
                                                       cartonQantity= calculateCartonQuantity(item);
                                                       boxQantity= calculateBoxQuantity(item);
                                                        CartonWeight =  calculateCartonWeight(item);
                                                        UnitWeight= calculateUnitWeight(item);
                                                        if (item.UOM.toString() ==
                                                            "Carton") {
                                                          Carton_weight = (item
                                                              .quantity! *
                                                              item.Weight_Per_Carton!);
                                                          unit_weight = (((item
                                                              .quantity! *
                                                              item.unitPerCarton!) *
                                                              item.Weight_Per_Unit!));
                                                        } else {
                                                          Carton_weight = ((item
                                                              .quantity! /
                                                              item.unitPerCarton!) *
                                                              item.Weight_Per_Carton!);
                                                          unit_weight = ((item
                                                              .quantity! *
                                                              item.Weight_Per_Unit!));
                                                        }
                                                        if (item.UOM.toString() ==
                                                            "Carton") {
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
                                                        } else {
                                                          totalSchemeDiscountAmount = (item
                                                              .quantity! /
                                                              item.unitPerBox! *
                                                              item.schemeDisc!) ??
                                                              0;
                                                          Total_Trade_discount_Amount = (item
                                                              .quantity! /
                                                              item.unitPerBox! *
                                                              item.tradeDisc!) ??
                                                              0;
                                                          Total_Other_discount_Amount = (item
                                                              .quantity! /
                                                              item.unitPerBox! *
                                                              item.otherDisc!) ??
                                                              0;
                                                        }
                                                        TotalAfterDiscount =
                                                            calculateTotalAfterDiscount(
                                                                item);

                                                        var GST1 =
                                                        calculateGstCharge(
                                                            item,
                                                            item.gstPer);
                                                        GST = double.parse(GST1
                                                            .toStringAsFixed(2));

                                                        log("companyStateCode ${companyStateCode} Distributor_state_code ${Distributor_state_code}");

                                                        if (companyStateCode ==
                                                            Distributor_state_code ||
                                                            (Distributor_state_code ==
                                                                "24" &&
                                                                companyStateCode ==
                                                                    "24")) {
                                                          log("CGST---SGST");
                                                          CGST =
                                                              calculateGstCharge(
                                                                  item,
                                                                  item.gstPer);
                                                          CGST = double.parse(CGST
                                                              .toStringAsFixed(
                                                              2));
                                                          SGST =
                                                              calculateGstCharge(
                                                                  item,
                                                                  item.gstPer);
                                                          SGST = double.parse(SGST
                                                              .toStringAsFixed(
                                                              2));
                                                          log("CGST ${CGST}---SGST${SGST}");
                                                          if (TCS_Applicable ==
                                                              "Yes") {
                                                            TCS = calculateRowTCS(
                                                                totalSchemeDiscountAmount,
                                                                Total_Trade_discount_Amount,
                                                                Total_Other_discount_Amount,
                                                                SGST,
                                                                CGST,
                                                                IGST);
                                                            TCS = double.parse(
                                                                TCS.toString());
                                                          }
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
                                                          log("TCS_Applicable" +
                                                              TCS_Applicable
                                                                  .toString());
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
                                                        setState(() {
                                                          item.total = total;
                                                          item.totalSchemeDiscountAmount = totalSchemeDiscountAmount;
                                                          item.Total_Trade_discount_Amount = Total_Trade_discount_Amount;
                                                          item.Total_Other_discount_Amount = Total_Other_discount_Amount;
                                                          item.TotalAfterDiscount = TotalAfterDiscount;
                                                          item.GST = GST;
                                                          item.SGST = SGST;
                                                          item.IGST = IGST;
                                                          item.CGST = CGST;
                                                          item.TCS = TCS;
                                                          item.UOM=dropdownValue0[itemIndex];
                                                          item.UnitWeight=unit_weight;
                                                          item.CartonWeight=unit_weight;
                                                          item.unitQantity=unitQantity;
                                                          item.cartonQantity=cartonQantity;
                                                          item.boxQantity=boxQantity;
                                                        });

                                                        if ((itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"]) != -1) && (itemList.indexWhere((element) => element.UOM == dropdownValue0[itemIndex])) != -1) {
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].quantity = int.parse(value);
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].total = total;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].totalSchemeDiscountAmount = totalSchemeDiscountAmount;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].Total_Trade_discount_Amount = Total_Trade_discount_Amount;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].Total_Other_discount_Amount = Total_Other_discount_Amount;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].TotalAfterDiscount = TotalAfterDiscount;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].GST = GST;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].SGST = SGST;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].IGST = IGST;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].CGST = CGST;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].TCS = TCS;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].UnitWeight = UnitWeight;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].CartonWeight = CartonWeight;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].unitQantity = unitQantity;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].cartonQantity = cartonQantity;
                                                          itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].boxQantity = boxQantity;
                                                       //   itemList[itemList.indexWhere((element) => element.itemCode == offlineItem[itemIndex]["Item_id"])].UOM = item.UOM;
                                                        } else {
                                                          itemList.add(item);

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
                              })),
                  Container(
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.blue),
                              onPressed: () {
                                setState(() {
                                  _scaffoldKey.currentState!.openDrawer();
                                });
                              },
                              child:  Center(
                                child: Container(
                                  // width: 30,
                                  // height: 30,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 30,
                                        child: Icon(
                                          CupertinoIcons.cart,
                                          color: Colors.white,
                                          // size: 30,
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(top: 0),
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffc32c37),
                                              border: Border.all(color: Colors.white, width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Center(
                                              child: Text(
                                                itemList.length.toString(),
                                                style: TextStyle(fontSize: 10,color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // label:  Text(
                              //   "Get Direction",
                              //   style: TextStyle(
                              //       color: Colors.white),
                              // ),
                            ),
                          ),
                        ),
                        /*Expanded(
                          child: Padding(
                            padding:  EdgeInsets.all(5.0),
                            child: SizedBox(
                              // width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.green),
                                onPressed: () {
                                  setState(() {});

                                },
                                icon:  Icon(CupertinoIcons.cart,color: Colors.white,),
                                label:  Text(
                                  "${offlineItem.length}",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),*/
                        Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                setState(() {});

                              },
                              child:  Text(
                                "Items:- ${offlineItem.length}",
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                              // label:  Text(
                              //   "Shop Close",
                              //   style: TextStyle(
                              //       color: Colors.white),
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                setState(() {});
                                if(selectedWareHouse!=""&&itemList.length != 0) {
                                  var totalofwsp = 0.0;
                                  double totalofIgst = 0.0;
                                  double totalofcgst = 0.0;
                                  double totalofsgst = 0.0;
                                  double totalofgst = 0.0;
                                  double totalofScemeDiscount = 0.0;
                                  double totaloftredDiscount = 0.0;
                                  double totalofotherDiscount = 0.0;
                                  double totalOrderValue = 0.0;
                                  double totalOFtcs = 0.0;
                                  double temp_roundoff = 0.0;
                                  double roundOff = 0.0;
                                  double totalCarton = 0.0;
                                  double total = 0.0;
                                  var LocalFieldString;
                                  setState(() {
                                    for (var item in itemList) {
                                      totalofcgst += item.CGST!;
                                      totalofsgst += item.SGST!;
                                      totalofIgst += item.IGST!;
                                      totalofScemeDiscount +=
                                      item.totalSchemeDiscountAmount!;
                                      totaloftredDiscount +=
                                      item.Total_Trade_discount_Amount!;
                                      totalofotherDiscount +=
                                      item.Total_Other_discount_Amount!;
                                      totalOFtcs += item.TCS!;
                                      totalofgst = totalofcgst + totalofsgst + totalofIgst;

                                      totalofwsp += item.total;
                                      totalOrderValue = totalofwsp -
                                          (totalofScemeDiscount +
                                              totaloftredDiscount +
                                              totalofotherDiscount) +
                                          totalOFtcs +
                                          totalofcgst +
                                          totalofsgst +
                                          totalofIgst;
                                      roundOff =
                                          totalofwsp + totalofgst + totalOFtcs;
                                      log(roundOff);
                                      double value = roundOff;
                                      double decimalPart = getDecimalPart(value);
                                      log("RoundOffValue" +
                                          decimalPart.toString());

                                      if (decimalPart < 0.5) {
                                        temp_roundoff = decimalPart;
                                      } else {
                                        temp_roundoff = 1 - decimalPart;
                                      }
                                      log("Final Round off" +
                                          temp_roundoff.toString());
                                    }
                                    log("totalCarton" + totalCarton.toString());
                                    log(itemList);
                                    String fieldString="";
                                    for(var e in itemList){

                                      fieldString += '{"${"CO_CODE"}":"${companyId}", "${"UR_CODE"}":"${UR_CODE}", "${"cur_date"}":"${formattedDate}", "${"cur_time"}":"${formattedDateTime}","${"URN_NO"}": "${urnNO}","${"IT_CODE"}": "${e
                                          .itemCode}", "${"it_name"}":"${e
                                          .it_name}", "${"rate"}":"${e
                                          .rate}", "${"UOM"}": "${e
                                          .UOM}", "${"quantity"}": "${e
                                          .quantity}", "${"total"}":"${e
                                          .total}", "${"Wsp_rate"}": "${e
                                          .wspRate}", "${"GST_PER"}": "${e
                                          .gstPer}", "${"GST_Charge"}": "${e
                                          .GST}","${"Unit_Per_Box"}": "${e
                                          .unitPerBox}", "${"Unit_Per_Carton"}": "${e
                                          .unitPerCarton}", "${"Weight_Per_Unit"}": "${e
                                          .Weight_Per_Unit}","${"Weight_Per_Carton"}": "${e
                                          .Weight_Per_Carton}", "${"Carton_quantity"}": "${e
                                          .cartonQantity!}", "${"Box_quantity"}": "${e
                                          .boxQantity}", "${"Unit_quantity"}": "${e
                                          .unitQantity}", "${"Price_Calc"}": "${e
                                          .priceCalc}", "${"Carton_weight"}": "${e
                                          .CartonWeight!/ 1000}", "${"Unit_weight"}": "${e
                                          .UnitWeight}", "${"CGST"}": "${e.gstPer! /
                                          2}", "${"SGST"}": "${e.gstPer! /
                                          2}", "${"IGST"}": "${e
                                          .gstPer!}", "${"Scheme_discount"}": "${e
                                          .schemeDisc}", "${"Trade_Disc"}": "${e
                                          .tradeDisc}", "${"Other_Disc"}": "${e
                                          .otherDisc}", "${"CGST_Amount"}": "${e
                                          .CGST}", "${"SGST_Amount"}": "${e
                                          .SGST}", "${"IGST_Amount"}": "${e
                                          .IGST}", "${"Total_scheme_discount_Amount"}": "${e
                                          .totalSchemeDiscountAmount}", "${"Total_Trade_discount_Amount"}": "${e
                                          .Total_Trade_discount_Amount}", "${"Total_Other_discount_Amount"}": "${e
                                          .Total_Other_discount_Amount}", "${"TCS"}":"${e
                                          .TCS}", "${"HSN_CODE"}": "${e
                                          .HSN_CODE}", "${"Freight_Amt"}": "${e
                                          .Freight_Amt ??
                                          0.0}", "${"Std_Amt"}": "${e.Std_Amt ??
                                          0.0}", "${"NCC_Duty"}": "${e.NCC_Duty ??
                                          "0"}", "${"total_after_discount"}": "${TotalAfterDiscount}" },';
                                    }
                                    String stringWithoutParentheses = fieldString.toString().replaceAll('(', '').replaceAll(')', '');
                                    log("stringWithoutParentheses" + stringWithoutParentheses.toString());
                                    String result = stringWithoutParentheses.substring(0, stringWithoutParentheses.length - 1);
                                    LocalFieldString =
                                    '{"${"CO_CODE"}":"${companyId}", "${"Created_by"}":"${role}", "${"UR_CODE"}":"${UR_CODE}", "${"Factory_id"}":"${factoryId}", "${"business_id"}":"${""}", "${"cur_date"}":"${formattedDate}", "${"cur_time"}":"${formattedDateTime}", "${"URN_NO"}":"${"$urnNO"}", "${"billing_address"}":"${selectedWareHouse}", "${"SR_NO"}":"${""}", "${"Remarks_dealer"}": "${""}", "${"Remarks_rsm"}":"${""}", "${"PO_Status"}":"${"RSM Approval"}", "${"Fyear"}":"${"2023-2024"}", "${"Round_Off"}":"${temp_roundoff.toDouble().toStringAsFixed(2)}", "${"Order_Total"}":"${totalOrderValue.roundToDouble()}", "${"Reason"}":"${""}", "${"shipping_address"}":"${selectedWareHouse}", "${"PO_approval_date"}":"${""}", "${"ERP_URN"}":"${""}", "${"DO_NO"}":"${""}", "${"Do_Date"}":"${""}","${"Item"}": [${result
                                        .toString()}]}';
                                  });
                                  log(LocalFieldString);
                                  showSummaryDialog(
                                      totalofcgst,
                                      totalofsgst,
                                      totalofIgst,
                                      totalofgst,
                                      totalofwsp,
                                      totalOrderValue,
                                      temp_roundoff,
                                      totalofScemeDiscount,
                                      LocalFieldString);
                                }else{
                                  if(selectedWareHouse==""){
                                    Fluttertoast.showToast(
                                        msg: "Please Select Billing Address!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  else if(itemList.length == 0){
                                    Fluttertoast.showToast(
                                        msg: "Please Add item in cart for place order!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                        msg: "Please Select Billing Address and Add item in cart for place order!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }

                                }
                              },
                              child:  Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  color: Colors.white,
                                  height: 30,
                                  width: 30,
                                  image: AssetImage('images/pendingcart.png'),
                                ),
                              ),
                              // label:  Text(
                              //   "Shop Close",
                              //   style: TextStyle(
                              //       color: Colors.white),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getDecimalPart(double value) {
    // Convert the double to a string and split it using the decimal point
    List<String> parts = value.toString().split('.');

    // If the double has no decimal part, return 0
    if (parts.length != 2) {
      return 0.0;
    }

    // Parse the decimal part and return it as a double
    double decimal = double.parse('0.${parts[1]}');
    return decimal;
  }

  double calculateRowTCS(totalSchemeDiscountAmount, Total_Trade_discount_Amount,
      Total_Other_discount_Amount, sgstAmount, cgstAmount, igstAmount) {
    double rowTCS = (total -
            (totalSchemeDiscountAmount +
                Total_Trade_discount_Amount +
                Total_Other_discount_Amount) +
            sgstAmount +
            cgstAmount +
            igstAmount) *
        0.001;

    return rowTCS;
  }
  double calculateCartonWeight(Item item) {
    if (item.UOM.toString() ==
        "Carton") {

    return ((item.quantity!  * item.Weight_Per_Carton!)/1000);
    } else {
      return (((item.quantity! / item.unitPerCarton!) * item.Weight_Per_Carton!)/1000);
    }

  }

  double calculateUnitWeight(Item item) {
    if (item.UOM.toString() ==
        "Carton") {
      return ((item.quantity! * item.Weight_Per_Carton!)*item.Weight_Per_Unit! ).roundToDouble();
    } else {
      return (item.quantity! * item.Weight_Per_Unit!).roundToDouble();
    }
  }
  double calculateCartonQuantity(Item item) {
    if (item.UOM.toString() ==
        "Carton") {
      return item.quantity!.roundToDouble();
    } else {
      //panding
      return (item.quantity! / item.unitPerCarton!).roundToDouble();
    }

  }

  double calculateBoxQuantity(Item item) {
    if (item.UOM.toString() ==
        "Carton") {
      return ((item.quantity! * item.unitPerCarton!) / item.unitPerBox!);
    } else {
      //pending
      log("BOX qty for unit ${item.UOM} ${item.quantity!/ item.unitPerBox!}");
      return (item.quantity!/ item.unitPerBox!);
    }
  }

  double calculateUnitQuantity(Item item) {
    if (item.UOM.toString() ==
        "Carton") {
      return (item.quantity! * item.unitPerCarton!);
    } else {
      //pending
      return (item.quantity!).roundToDouble();
    }
  }
// Uom Done
  double calculateIGSTAmount(Item item, gstper) {
    double IGST = gstper / 100;
    log(IGST.toString());
    if (item.UOM.toString() == "Carton") {
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
      }
    } else {
      if (item.priceCalc == 'unit') {
        double baseAmount = ((((item.quantity! * item.wspRate!) -
                    ((item.quantity! / item.unitPerBox!) * item.schemeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.tradeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.otherDisc!)) *
                gstper!) /
            100);
        return baseAmount > 0 ? baseAmount : 0;
      } else if (item.priceCalc == 'box') {
        double baseAmount = (((((item.quantity! / item.unitPerBox!) *
                        item.wspRate!) -
                    ((item.quantity! / item.unitPerBox!) * item.schemeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.tradeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.otherDisc!)) *
                gstper!) /
            100);
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

// Uom Done
  double calculateSGSTAmount(Item item, gstper) {
    var Sgst = gstper / 2;
    if (item.UOM.toString() == "Carton") {
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
                        Sgst /
                        100) ??
                0;
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    } else {
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
                        Sgst /
                        100) ??
                0;
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

// Uom Done
  double calculateCGSTAmount(Item item, gstper) {
    var Cgst = gstper / 2;
    log(Cgst);
    if (item.UOM.toString() == "Carton") {
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
                Cgst) /
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
      }
    } else {
      if (item.priceCalc == 'unit') {
        log(item.quantity! * item.wspRate!);
        log((item.quantity!) * (item.schemeDisc ?? 0));
        double baseAmount = (item.quantity! * item.wspRate!) -
            ((((item.quantity! / item.unitPerBox!) * (item.schemeDisc ?? 0)) +
                    ((item.quantity! / item.unitPerBox!) *
                        (item.tradeDisc ?? 0)) +
                    ((item.quantity! / item.unitPerBox!) *
                        (item.otherDisc ?? 0))) *
                (Cgst / 100));
        return baseAmount > 0 ? baseAmount : 0;
      } else if (item.priceCalc == 'box') {
        double baseAmount =
            (((item.quantity! / item.unitPerBox!) * item.wspRate!) -
                    (((item.quantity! / item.unitPerBox!) *
                                (item.schemeDisc ?? 0)) +
                            ((item.quantity! / item.unitPerBox!) *
                                (item.tradeDisc ?? 0)) +
                            ((item.quantity! / item.unitPerBox!) *
                                (item.otherDisc ?? 0))) *
                        (Cgst / 100)) ??
                0;
        return baseAmount > 0 ? baseAmount : 0;
      } else {
        return 0;
      }
    }
  }

// Uom Done
  double calculateTotalAfterDiscount(Item item) {
    if (item.UOM.toString() == "Carton") {
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
    } else {
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

// Uom Done
  double calculateGstCharge(Item item, gstper) {
    var Cgst = gstper / 2;
    double gstCharge;
    if (item.UOM.toString() == "Carton") {
      if (item.priceCalc == 'unit') {
        gstCharge = ((((item.unitPerCarton! * item.quantity! * item.wspRate!) -
                    ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        item.schemeDisc!) -
                    ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        item.tradeDisc!) -
                    ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
                        item.otherDisc!)) *
                Cgst) /
            100);
      } else if (item.priceCalc == 'box') {
        gstCharge =
            (((((item.quantity! * item.unitPerCarton! / item.unitPerBox!) -
                            item.schemeDisc!) -
                        item.tradeDisc! -
                        item.otherDisc!) *
                    item.wspRate! *
                    Cgst) /
                100);
      } else {
        // Handle the case when priceCalc is neither 'unit' nor 'box'
        gstCharge =
            0.0; // You may want to choose a default value or handle this case differently
      }
    } else {
      if (item.priceCalc == 'unit') {
        gstCharge = ((((item.unitPerCarton! * item.wspRate!) -
                    ((item.quantity! / item.unitPerBox!) * item.schemeDisc!) -
                    ((item.quantity! / item.unitPerBox!) * item.tradeDisc!) -
                    ((item.quantity! / item.unitPerBox!) * item.otherDisc!)) *
                Cgst!) /
            100);
      } else if (item.priceCalc == 'box') {
        gstCharge = (((((item.quantity! / item.unitPerBox!) * item.wspRate!) -
                    ((item.quantity! / item.unitPerBox!) * item.schemeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.tradeDisc!) +
                    ((item.quantity! / item.unitPerBox!) * item.otherDisc!)) *
                Cgst!) /
            100);
      } else {
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

  // Uom Done
  double calculateTotal(Item item) {
    double total;
    log(item.UOM.toString());
    if (item.UOM.toString() == "Carton") {
      log("Nakul");
      if (item.priceCalc == 'unit') {
        total = (item.unitPerCarton! * item.quantity! * item.wspRate!);
      } else if (item.priceCalc == 'box') {
        total = ((item.quantity! * item.unitPerCarton! / item.unitPerBox!) *
            item.wspRate!);
      } else {
        total =
            0.0; // You may want to choose a default value or handle this case differently
      }
    } else {
      log("Nakul..........");
      if (item.priceCalc == 'unit') {
        total = (item.quantity! * item.wspRate!);
      } else if (item.priceCalc == 'box') {
        total = ((item.quantity! / item.unitPerBox!) * item.wspRate!);
      } else {
        total =
            0.0; // You may want to choose a default value or handle this case differently
      }
    }
    return total;
  }

  void showSummaryDialog(totalofcgst, totalofsgst, totalofIgst, totalofgst,
      totalofwsp, totalOrderValue, temp_roundoff,totalofScemeDiscount,LocalFieldString) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => OrderSummaryScreen(
            totalofwsp.toString(),
            totalofgst.toString(),
            totalofcgst.toString(),
            totalofsgst.toString(),
            totalofIgst.toString(),
            TCS.toString(),
            totalOrderValue,
            itmval,
            temp_roundoff,totalofScemeDiscount,LocalFieldString));
  }

  openHiveBoxFORfshipmasterData() async {
    var box = await Hive.openBox('fshipmasterData');
    var bookmark = box.get('fshipmasterData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        debugPrint("DATA ${value[0]}");
        selectionItems = value;
        print("selectionItems.length " + selectionItems.length.toString());
        if (selectionItems.length == 1) {
          compneyNameController.text = selectionItems[0]['Warehouse_Name'];
          selectedWareHouse = selectionItems[0]['Warehouse_id'];
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
  double? rate;
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
  dynamic total;
  double? totalSchemeDiscountAmount;
  double? Total_Trade_discount_Amount;
  double? Total_Other_discount_Amount;
  double? TotalAfterDiscount;
  double? GST;
  double? SGST;
  double? IGST;
  double? CGST;
  double? TCS;double? CartonWeight;double? UnitWeight;double? unitQantity;double? cartonQantity;double? boxQantity;

  Item({
    this.itemCode,
    this.it_name,
    this.rate,
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
    this.total,
    this.CGST,
    this.SGST,
    this.IGST,
    this.totalSchemeDiscountAmount,
    this.TotalAfterDiscount,
    this.Total_Other_discount_Amount,
    this.Total_Trade_discount_Amount,
    this.GST,
    this.TCS,
    this.CartonWeight,
    this.UnitWeight,
    this.boxQantity,
    this.cartonQantity,
    this.unitQantity
  });

  // Method to convert Item object to JSON
  Map<String, dynamic> toJson() {
    return {
      'itemCode': itemCode,
      'it_name': it_name,
      'rate': rate,
      'UOM': UOM,
      'NCC_Duty': NCC_Duty,
      'wspRate': wspRate,
      'gstPer': gstPer,
      'priceCalc': priceCalc,
      'HSN_CODE': HSN_CODE,
      'unitPerCarton': unitPerCarton,
      'Std_Amt': Std_Amt,
      'Freight_Amt': Freight_Amt,
      'Weight_Per_Unit': Weight_Per_Unit,
      'Weight_Per_Carton': Weight_Per_Carton,
      'quantity': quantity,
      'unitPerBox': unitPerBox,
      'schemeDisc': schemeDisc,
      'tradeDisc': tradeDisc,
      'otherDisc': otherDisc,
      'cgst': cgst,
    };
  }
}
