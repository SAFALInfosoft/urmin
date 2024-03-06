import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../../../Calculation/calculateTotal.dart';
import '../../../DMS_Screens/PrimarySales/PendingGRN/summeryScreen.dart';
import '../../../GlobalComponents/PreferenceManager.dart';
import '../../../constant.dart';
import 'package:intl/intl.dart';

import '../SummaryScreen.dart';

class POEditPage extends StatefulWidget {
  final String distributor_id;

  POEditPage({
      required this.distributor_id,
      Key? key}) : super(key: key);

  @override
  _POEditPageState createState() => _POEditPageState();
}

class _POEditPageState extends State<POEditPage> {
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
  double schemeDisc = 0.0;
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
  var isLoading = false;


  List<dynamic?> itmval = [];

  var TCS_Applicable;

  List cartArray = [];
  String? clientUrl;

  String selectedCetagory = '';

  List filterList = [];
  List selectionItems = [];

  List<Item> itemList = [];

  Iterable<String> FieldString = [];

  String? companyId, factoryId, price_id;
  String parent_Name = "";
  String subCategory_Name = "";

  //String ? parent_Name;

  var UR_CODE;

  Box? box;

  double UnitWeight = 0.0;
  double CartonWeight = 0.0;
  double unitQantity = 0.0;
  double cartonQantity = 0.0;
  double boxQantity = 0.0;
  int selectedTile = -1;


  var token, coCode, userId;


  // openHiveBox() async {
  //   var box = await Hive.openBox('erpApiMainData');
  //   var bookmark = box.get('erpApiMainData');
  //
  //   bookmark.forEach((key, value) {
  //     log(key.toString());
  //     if (key == 'docs') {
  //       debugPrint("DATA ${value[0]['gst'][0]['state_code']}");
  //       setState(() {
  //         TCS_Applicable = value[0]['TCS_Applicable'];
  //         Distributor_state_code = value[0]['gst'][0]['state_code'].toString();
  //       });
  //     }
  //   });
  // }

  List<Map<String, dynamic>> onlineItemList = [];

  // openHiveBoxFORITEMSData() async {
  //   var box = await Hive.openBox('ItemList');
  //   var bookmark = box.get('ItemList');
  //
  //   // Check if bookmark is not null before accessing its properties
  //   if (bookmark != null) {
  //     // Clear the previous items
  //     onlineItemList.clear();
  //
  //     // Ensure that the data is of type List<Map<String, dynamic>>
  //     if (bookmark is List && bookmark.isNotEmpty && bookmark.first is Map<String, dynamic>) {
  //       onlineItemList.addAll(List<Map<String, dynamic>>.from(bookmark));
  //     } else {
  //       // Handle the case where the data is not of the expected type
  //       print("Invalid data format in Hive box 'ItemList'");
  //     }
  //
  //     // Sort onlineItemList
  //     onlineItemList.sort((a, b) => a["Item_name"].compareTo(b["Item_name"]));
  //
  //     setState(() {
  //       // You might want to update the UI or perform other actions here
  //     });
  //
  //     log("Updated onlineItemList: ${onlineItemList.length} items");
  //   }
  // }


  var list;
  String formattedDate = "";
  String formattedDateTime = "";

  @override
  void initState() {
    DateTime now = DateTime.now();

    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(now);
    print(formattedDate);
    box = Hive.box('PO_OfflineJson');
    Hive.openBox('PO_OfflineJson');
    var List = box!.get('PO_OfflineJson');
    log("POLISTJSON ${List}");
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {} else {
        kMainColor = Colors.red;
      }
    });
    //openHiveBox();
    PreferenceManager.instance
        .getStringValue("factoryId")
        .then((value) =>
        setState(() {
          factoryId = value;
          print("factoryId" + value);
        }));
    PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) =>
        setState(() {
          companyId = value;
          fcustomer();
          fpricelist();
          print("companyId" + value);
        }))
        .then((_) => fcustomer())
        .then((_) => fpricelist());

    // PreferenceManager.instance
    //     .getStringValue("Factory_id")
    //     .then((value) => setState(() async{
    //   factoryId = value;
    //   fpricelist();
    //   print("Factory_id" + value);
    //
    // }));
    //openHiveBoxFORfshipmasterData();
    // openHiveBoxFORITEMSData();
    PreferenceManager.instance
        .getStringValue("distributorId")
        .then((value) =>
        setState(() {
          UR_CODE = value;
          print("companyId" + value);
        }));

    PreferenceManager.instance
        .getStringValue("companyStateCode")
        .then((value) =>
        setState(() {
          companyStateCode = value;
          print(value);
        }));
    // PreferenceManager.instance
    //     .getStringValue("ClintUrl")
    //     .then((value) => setState((){
    //   clientUrl = value;
    // }));
    // fpricelist();
    fshipmaster();
    //fpricelist();
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
  TextEditingController companyNameController = TextEditingController();
  TextEditingController parent_NameController = TextEditingController();
  TextEditingController subCategory_NameController = TextEditingController();
  final GlobalKey<_POEditPageState> expansionTileKey = GlobalKey();

  var selectedWareHouse;

  @override
  Widget build(BuildContext context) {
    CheckUserConnection();

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
          'Edit PO',
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
                                      Text("WEIGHT: 0.0 KG"/*+itemList[index].Weight_Per_Carton.toString()*/,overflow: TextOverflow.ellipsis,),
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
                        child: CupertinoTextField(

                          //controller: controller,
                          readOnly: true,
                          placeholder: "Item Count :- ${onlineItemList.length}"
                          //"${onlineItemList.length}"
                          ,
                          placeholderStyle: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CupertinoSearchTextField(
                          //controller: controller,
                          onChanged: (value) {
                            _controllers.clear();
                            setState(() {
                              onlineItemList = onlineItemList
                                  .where((item) =>
                                  item["Item_name"]
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                            // filterSearchResults(value, context);
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
                          margin: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
                                        controller: companyNameController,
                                        // decoration: InputDecoration(
                                      ),
                                    ),
                                    onlineItemList.length > 1
                                        ? PopupMenuButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      onSelected: (value) {
                                        setState(() {
                                          var selectedItem = selectionItems
                                              .firstWhere((item) =>
                                          item["Warehouse_Name"] ==
                                              value);
                                          companyNameController.text =
                                              value.toString();
                                          // selectedWareHouse =
                                          // selectedItem["Warehouse_id"];
                                          //log(selectedWareHouse);
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            label: Text("Category"),
                                            border: InputBorder.none),
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                        controller: parent_NameController,
                                        // decoration: InputDecoration(
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      onSelected: (value) {
                                        setState(() {
                                          // var selectedItem = onlineItemList.firstWhere(
                                          //       (item) => item["Parent_Name"] == value,
                                          // );
                                          parent_NameController.text =
                                              value.toString();
                                          //selectedCode = selectedItem["Select_Value_Code"];
                                          //log(selectedCode);
                                        });
                                      },
                                      itemBuilder: (BuildContext context) {
                                        // onlineItemList.sort((a, b) =>
                                        //     a["Parent_Name"]
                                        //         .compareTo(b["Parent_Name"]));
                                        return onlineItemList
                                            .where((value) =>
                                            uniqueValues
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
                                                subCategory_NameController
                                                    .text ==
                                                    ""
                                                    ? "Sub Category"
                                                    : ""),
                                            border: InputBorder.none),
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                        controller: subCategory_NameController,
                                        // decoration: InputDecoration(
                                      ),
                                    ),
                                    Visibility(
                                      visible: parent_NameController.text == "" ? false : true,
                                      child: PopupMenuButton(
                                        icon: Icon(Icons.arrow_drop_down),
                                        onCanceled: () {
                                          // SubCategory_NameController.clear();
                                        },
                                        onSelected: (value) {
                                          setState(() {
                                            _controllers.clear();
                                            if (subCategory_NameController.text == "") {
                                              subCategory_NameController.text = value.toString();
                                              onlineItemList = onlineItemList
                                                  .where((item) =>
                                                  item["Category_Name"]
                                                      .toLowerCase()
                                                      .contains(subCategory_NameController.text.toLowerCase()))
                                                  .toList();
                                            } else {
                                              //SubCategory_NameController.clear();
                                              //onlineItemList = tempItem;
                                            }
                                          });
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            PopupMenuItem(
                                              child: Column(
                                                children: onlineItemList
                                                    .where((value) =>
                                                    uniqueValues2.add(subCategory_NameController.text ==
                                                        value["Item_name"]
                                                        ? value["Item_name"]
                                                        : "No Data"))
                                                    .map<Widget>((value) {
                                                  return ListTile(
                                                    title: Text(
                                                      value["Item_name"],
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        overflow: TextOverflow.visible,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context, value["Item_name"]);
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ];
                                        },
                                      ),
                                    ),

                                    InkWell(
                                        onTap: () {
                                          setState(() {});
                                          subCategory_NameController.clear();
                                          parent_NameController.clear();
                                          onlineItemList = onlineItemList;
                                          onlineItemList.sort((a, b) =>
                                              a["Item_name"]
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
                          child: onlineItemList == [] || onlineItemList == null
                              ? CircularProgressIndicator()
                              : ListView.builder(
                              itemCount:
                              onlineItemList == null || onlineItemList == []
                                  ? 0
                                  : onlineItemList.length,
                              itemBuilder: (ctx, itemIndex) {
                                onlineItemList.sort((a, b) =>
                                    a["Item_name"].compareTo(b["Item_name"]));
                                // _controllers.clear();
                                for (int i = 0; i < onlineItemList!.length; i++) {
                                  if (onlineItemList != null) {
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
                                                              onlineItemList[
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
                                                '\u{20B9} ${onlineItemList[itemIndex]['MRP']}',
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
                                                    //enabledBorder: OutlineInputBorder(),
                                                    labelText: 'Nos',
                                                    hintText: 'Nos',
                                                  ),
                                                  onChanged: (value) async {
                                                    String str = value;
                                                    if (value == '') {

                                                      print(
                                                          'removed 11 !! ${itemList.map((e) => e.quantity)}');
                                                      itemList.removeWhere((element) =>
                                                      (element.itemCode == onlineItemList[itemIndex]["Item_id"]) &&
                                                          (element.UOM == dropdownValue0[itemIndex]));
                                                      print('removed!! ${itemList.map((e) => e.UOM)}');
                                                      print('removed 11 !! ${itemList.map((e) => e.quantity)}');

                                                      log("FieldString" +
                                                          FieldString
                                                              .toString() +
                                                          "itemList langth" +
                                                          itemList.length
                                                              .toString());
                                                      log("itemList langth" +
                                                          itemList.length
                                                              .toString());
                                                    }
                                                    if (value.isNotEmpty) {

                                                      log(str.toString());
                                                      int qty =
                                                      int.parse(value);
                                                      // cartArray.add(onlineItemList[
                                                      //     itemIndex]);
                                                      // cart.add(onlineItemList[
                                                      //     itemIndex]);
                                                      log("CartArray" +
                                                          cart.toString());
                                                      log(dropdownValue0[
                                                      itemIndex]);
                                                      var scdc = onlineItemList[
                                                      itemIndex]
                                                      [
                                                      'Trade_Disc'] ==
                                                          ""
                                                          ? 0.0
                                                          : onlineItemList[
                                                      itemIndex]
                                                      ['Trade_Disc'];
                                                      var scmdc = onlineItemList[
                                                      itemIndex]
                                                      [
                                                      'Scheme_Disc'] ==
                                                          ""
                                                          ? 0.0
                                                          : onlineItemList[
                                                      itemIndex]
                                                      ['Scheme_Disc'];
                                                      var otrdc = onlineItemList[
                                                      itemIndex]
                                                      [
                                                      'Other_Disc'] ==
                                                          ""
                                                          ? 0.0
                                                          : onlineItemList[
                                                      itemIndex]
                                                      ['Other_Disc'];
                                                      double WSP = double.parse(
                                                          onlineItemList[itemIndex]
                                                          ['WSP']);
                                                      double Tax_Rate =
                                                      double.parse(
                                                          onlineItemList[
                                                          itemIndex]
                                                          ['Tax_Rate']);
                                                      double Unit_Per_Carton =
                                                      double.parse(onlineItemList[
                                                      itemIndex][
                                                      'Unit_Per_Carton']);
                                                      double Unit_Per_Box = double
                                                          .parse(onlineItemList[
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
                                                      double Weight_Per_Carton =
                                                      double.parse(onlineItemList[
                                                      itemIndex]
                                                      [
                                                      'Weight_Per_Carton']
                                                          .toString());
                                                      double MRP = double.parse(
                                                          onlineItemList[itemIndex]
                                                          ['MRP']
                                                              .toString());
                                                      double Weight_Per_Unit =
                                                      double.parse(onlineItemList[
                                                      itemIndex]
                                                      [
                                                      'Weight_Per_Unit']
                                                          .toString());
                                                      log("WSP" +
                                                          WSP.toString());
                                                      Item item = Item(
                                                          itemCode: onlineItemList[
                                                          itemIndex]
                                                          ['Item_id'],
                                                          it_name: onlineItemList[
                                                          itemIndex]
                                                          ['Item_name'],
                                                          UOM: dropdownValue0[
                                                          itemIndex],
                                                          rate: MRP,
                                                          wspRate: WSP,
                                                          gstPer: Tax_Rate,
                                                          priceCalc: onlineItemList[
                                                          itemIndex]
                                                          ['Price_Calc'],
                                                          unitPerCarton:
                                                          Unit_Per_Carton,
                                                          Weight_Per_Carton:
                                                          Weight_Per_Carton,
                                                          Weight_Per_Unit:
                                                          Weight_Per_Unit,
                                                          quantity: qty,
                                                          HSN_CODE: onlineItemList[
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
                                                      item.UOM =dropdownValue0[itemIndex];

                                                      //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      //   prefs.setStringList("cartProducts", item as List<String>);

                                                      /*var box = Hive.box('PO_OfflineJson');
                                                          box.put('added_itemjsonData', itmval);
                                                          await Hive.openBox('added_itemjsonData');
                                                          var List=box.get('added_itemjsonData');
                                                          log(List);*/

                                                      total = calculateTotal(item);
                                                      unitQantity = calculateUnitQuantity(item);
                                                      cartonQantity= calculateCartonQuantity(item);
                                                      boxQantity= calculateBoxQuantity(item);
                                                      CartonWeight=  calculateCartonWeight(item);
                                                      UnitWeight= calculateUnitWeight(item);
                                                      if (item.UOM.toString() ==
                                                          "Carton") {
                                                        Carton_weight = (item
                                                            .quantity! *
                                                            item.Weight_Per_Carton!);
                                                        unit_weight = ((item
                                                            .quantity! *
                                                            item.unitPerCarton!) *
                                                            item.Weight_Per_Unit!);
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

                                                      if ((itemList.indexWhere((element) =>
                                                      element
                                                          .itemCode ==
                                                          onlineItemList[
                                                          itemIndex]
                                                          [
                                                          "Item_id"]) !=
                                                          -1) &&
                                                          (itemList.indexWhere(
                                                                  (element) =>
                                                              element.UOM == dropdownValue0[itemIndex])) !=
                                                              -1) {
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].quantity = int.parse(value);
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].total = total;

                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].totalSchemeDiscountAmount = totalSchemeDiscountAmount;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].Total_Trade_discount_Amount = Total_Trade_discount_Amount;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].Total_Other_discount_Amount = Total_Other_discount_Amount;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].TotalAfterDiscount = TotalAfterDiscount;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].GST = GST;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].SGST = SGST;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].IGST = IGST;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].CGST = CGST;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].TCS = TCS;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].UnitWeight = UnitWeight;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].CartonWeight = CartonWeight;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].unitQantity = unitQantity;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].cartonQantity = cartonQantity;
                                                        itemList[itemList.indexWhere((element) => element.itemCode == onlineItemList[itemIndex]["Item_id"])].boxQantity = boxQantity;
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
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.cart,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Add to cart',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ],
                                ),
                                onPressed: () {
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
                                        if (item.UOM == "Carton") {
                                          //totalCarton = item.UOM!.length as double;
                                        } else {
                                          // totalCarton = item.UOM!.length as double;
                                        }
                                        totalofScemeDiscount +=
                                        item.totalSchemeDiscountAmount!;
                                        totaloftredDiscount +=
                                        item.Total_Trade_discount_Amount!;
                                        totalofotherDiscount +=
                                        item.Total_Other_discount_Amount!;
                                        totalOFtcs += item.TCS!;
                                        totalofgst =
                                            totalofcgst + totalofsgst + totalofIgst;

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
                                      //FieldString=  itemList.map((e) => "{'${"CO_CODE"}':'${companyId}', '${"UR_CODE"}':'${UR_CODE}', '${"cur_date"}':'${""}', ${"cur_time"}:'${""}', ${"URN_NO"}:'${""}','${"IT_CODE"}': '${e.itemCode}', '${"it_name"}':'${e.it_name}', '${"rate"}':${e.rate}, UOM: '${e.UOM}', quantity: ${e. quantity}, '${"total"}':${e.total}, '${"Wsp_rate"}': ${e.wspRate}, GST_PER: ${e.gstPer}, GST_Charge: ${e.GST},Unit_Per_Box: ${e.unitPerBox}, Unit_Per_Carton: ${e.unitPerCarton}, Weight_Per_Unit: ${e.Weight_Per_Unit},Weight_Per_Carton: ${e.Weight_Per_Carton}, Carton_quantity: '${""}', Box_quantity: '${""}', Unit_quantity: '${""}', Price_Calc: ${e. priceCalc}, Carton_weight: ${e.HSN_CODE}, Unit_weight: '${""}', CGST: '${e.gstPer!/2}', SGST: '${e.gstPer!/2}', IGST: '${e.gstPer!}', Scheme_discount: ${e.schemeDisc}, Trade_Disc: ${e.tradeDisc}, Other_Disc: ${e. otherDisc}, CGST_Amount: ${e.CGST}, SGST_Amount: ${e.SGST}, IGST_Amount: ${e.IGST}, Total_scheme_discount_Amount: ${e.totalSchemeDiscountAmount}, Total_Trade_discount_Amount: ${e.Total_Trade_discount_Amount}, Total_Other_discount_Amount: ${e.Total_Other_discount_Amount}, TCS:'${e.TCS}', HSN_CODE: ${e.HSN_CODE}, Freight_Amt: ${e.Freight_Amt??0.0}, Std_Amt: ${e.Std_Amt??0.0}, NCC_Duty: ${e.NCC_Duty??"0"}, total_after_discount: ${TotalAfterDiscount} }");
                                      FieldString = itemList.map((e) =>
                                      '{"${"CO_CODE"}":"${companyId}", "${"UR_CODE"}":"${UR_CODE}", "${"cur_date"}":"${formattedDate}", "${"cur_time"}":"${formattedDateTime}","${"URN_NO"}": "${""}","${"IT_CODE"}": "${e
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
                                          .cartonQantity}", "${"Box_quantity"}": "${e
                                          .boxQantity}", "${"Unit_quantity"}": "${e
                                          .unitQantity}", "${"Price_Calc"}": "${e
                                          .priceCalc}", "${"Carton_weight"}": "${e
                                          .CartonWeight}", "${"Unit_weight"}": "${e
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
                                          "0"}", "${"total_after_discount"}": "${TotalAfterDiscount}" }');
                                      String stringWithoutParentheses =
                                      FieldString.toString()
                                          .replaceAll('(', '')
                                          .replaceAll(')', '');
                                      log("stringWithoutParentheses" +
                                          stringWithoutParentheses.toString());
                                      var LocalFieldString = "[{'${"CO_CODE"}':'${companyId}', '${"UR_CODE"}':'${UR_CODE}', '${"Factory_id"}':'${factoryId}', '${"business_id"}':'${""}', '${"cur_date"}':'${""}', '${"cur_time"}':'${""}', '${"URN_NO"}':${"1"}, ${"billing_address"}:'${selectedWareHouse}', ${"SR_NO"}:'${""}', ${"Remarks_dealer"}: '${""}', ${"Remarks_rsm"}:'${""}', ${"PO_Status"}:${"RSM_Approval"}, ${"Fyear"}:'${"2023-2024"}', ${"Round_Off"}:'${temp_roundoff}', ${"Order_Total"}:'${totalOrderValue}', ${"Reason"}:'${""}', ${"shipping_address"}:'${selectedWareHouse}', ${"PO_approval_date"}:'${""}', ${"ERP_URN"}:'${""}', ${"DO_NO"}:'${""}', ${"Do_Date"}:'${""}',Item: [${stringWithoutParentheses.toString()}]}]";
                                      LocalFieldString =
                                      '{"${"CO_CODE"}":"${companyId}", "${"UR_CODE"}":"${UR_CODE}", "${"Factory_id"}":"${factoryId}", "${"business_id"}":"${""}", "${"cur_date"}":"${formattedDate}", "${"cur_time"}":"${formattedDateTime}", "${"URN_NO"}":"${""}", "${"billing_address"}":"${selectedWareHouse}", "${"SR_NO"}":"${""}", "${"Remarks_dealer"}": "${""}", "${"Remarks_rsm"}":"${""}", "${"PO_Status"}":"${"RSM Approval"}", "${"Fyear"}":"${"2023-2024"}", "${"Round_Off"}":"${temp_roundoff}", "${"Order_Total"}":"${totalOrderValue}", "${"Reason"}":"${""}", "${"shipping_address"}":"${selectedWareHouse}", "${"PO_approval_date"}":"${""}", "${"ERP_URN"}":"${""}", "${"DO_NO"}":"${""}", "${"Do_Date"}":"${""}","${"Item"}": [${stringWithoutParentheses
                                          .toString()}]}';
                                      log(LocalFieldString);
                                      log("FieldString" +
                                          FieldString.toString() +
                                          "itemList langth" +
                                          itemList.length.toString());
                                      log(itemList.length.toString());
                                    });

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
                                    }else if(itemList.length == 0){
                                      Fluttertoast.showToast(
                                          msg: "Please Add item in cart for place order!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }else{
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
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(kMainColor)),
                              ))),
                    ]
                ),
              ))
        ],
      ),
    );
  }

  // openHiveBoxFORfshipmasterData() async {
  //   var box = await Hive.openBox('fshipmasterData');
  //   var bookmark = box.get('fshipmasterData');
  //   bookmark.forEach((key, value) {
  //     log(key.toString());
  //     if (key == 'docs') {
  //       //debugPrint("DATA ${value[0]}");
  //       selectionItems = value;
  //       print("selectionItems.length " + selectionItems.length.toString());
  //       if (selectionItems.length == 1) {
  //         compneyNameController.text = selectionItems[0]['Warehouse_Name'];
  //         selectedWareHouse = selectionItems[0]['Warehouse_id'];
  //         // selectedCode = selectionItems[0]['Select_Value_Code'];
  //       }
  //       log(selectionItems);
  //       // setState(() {
  //       //   Distributor_state_code=value[0]['gst'][0]['state_code'].toString();
  //       // });
  //     }
  //   });
  // }

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
      "selector": {"Distributor_id": widget.distributor_id}
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
        String compneyName = "";
        if (body != null && body.isNotEmpty) {
          companyId = body['docs'][0]['Company_id'];
          factoryId = body['docs'][0]['Factory_id'];
          compneyName = body['docs'][0]['Warehouse_Name'];
        }
        companyNameController.text = compneyName;
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

  Future<void> fcustomer() async {
    setState(() {
      idLoading = true;
    });

    String apiUrl = 'http://api.urmingroup.co.in/fcustomer/_find';

    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    Map<String, dynamic> requestPayload = {
      "selector": {
        "Distributor_id": widget.distributor_id,
        "Company_id": companyId
      }
    };
    log(requestPayload);
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
        // Map<String, dynamic> responseBody = json.decode(response.body);
        //
        // debugPrint("fcustomer responseBody $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fcustomerData ${body}");

        // var box = Hive.box('fcustomerData');
        // box.put('fcustomerData', body);
        // await Hive.openBox('fcustomerData');
        // Map<String, dynamic> bookmark = box.get('fcustomerData');
        // bookmark.forEach((key, value) {
        //   if (key == 'docs') {
        //     debugPrint("fcustomerData $value");
        //   }
        // });
        if (body != null && body.isNotEmpty) {
          price_id = body['docs'][0]['Price_id'];
        }
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

    String apiUrl = 'http://api.urmingroup.co.in/fpricelist/_find';

    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    Map<String, dynamic> requestPayload = {
      "selector": {
        "Company_id": companyId,
        "Factory_id": factoryId,
        "Price_id": price_id
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

        final body = jsonDecode(response.body);
        debugPrint("responseBody fpricelist ${body}");

        if (body != null && body.isNotEmpty) {
          price_id = body['docs'][0]['Price_id'];
          parent_Name = body['docs'][0]['item'][0]['Parent_Name'];
          subCategory_Name = body['docs'][0]['item'][0]['Category_Name'];

          onlineItemList.clear();

          for (var itemData in body['docs'][0]['item']) {
            String itemId = itemData['Item_id'];
            String itemName = itemData['Item_name'];
            String MRP = itemData['MRP'];
            String WSP = itemData['WSP'];
            String Tax_Rate = itemData['Tax_Rate'];
            String Unit_Per_Carton = itemData['Unit_Per_Carton'];
            String Unit_Per_Box = itemData['Unit_Per_Box'];
            String Weight_Per_Carton = itemData['Weight_Per_Carton'];
            String scmdc = itemData['Scheme_Disc'];
            String scdc = itemData['Trade_Disc'];
            String otrdc = itemData['Other_Disc'];
            String Weight_Per_Unit = itemData['Weight_Per_Unit'];
            String HSN_CODE = itemData['HSN'];
            String priceCalc = itemData['Price_Calc'];



            Map<String, dynamic> item = {
              'Item_id': itemId,
              'Item_name': itemName,
              'MRP': MRP,
              'WSP':WSP,
              'Tax_Rate':Tax_Rate,
              'Unit_Per_Carton':Unit_Per_Carton,
              'Unit_Per_Box':Unit_Per_Box,
              'Weight_Per_Carton':Weight_Per_Carton,
              'Scheme_Disc':scmdc,
              'Trade_Disc':scdc,
              'Other_Disc':otrdc,
              'Weight_Per_Unit':Weight_Per_Unit,
              'HSN':HSN_CODE,
              'Price_Calc':priceCalc
            };

            onlineItemList.add(item);
            print(onlineItemList.length);
          }

          // Now itemList contains a list of items from the response
          // You can use this list as needed

          parent_NameController.text = parent_Name;
          subCategory_NameController.text = subCategory_Name;
        } else {
          setState(() {
            idLoading = false;
          });
          // Handle error
          print('API call failed with status code: ${response.statusCode}');
          print(response.body);
        }
      }
    } catch (error) {
      setState(() {
        idLoading = false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
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

      return (item.quantity!  * item.Weight_Per_Carton!).roundToDouble();
    } else {
      return ((item.quantity! / item.unitPerCarton!) * item.Weight_Per_Carton!).roundToDouble();
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
      return (item.quantity! * item.unitPerBox!).roundToDouble();
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
        builder: (BuildContext context) => SummaryScreen(
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


}
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
