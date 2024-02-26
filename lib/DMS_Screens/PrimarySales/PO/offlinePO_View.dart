// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:maan_hrm/Screens/Employee%20Overtime/empty_employee_overtime.dart';
import 'package:maan_hrm/Screens/Employee%20management/empty_employee.dart';
import 'package:maan_hrm/Screens/Leave%20Managemenr/leave_management.dart';
import 'package:maan_hrm/Screens/Reference%20Management/empty_reference.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/empty_salary_statement.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendance_employee_list.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../GlobalComponents/PreferenceManager.dart';
import '../../../RESPONSE/offline_PODATA_Response.dart';
import '../../../RESPONSE/posync_Response.dart';
import '../../../Screens/Authentication/sign_in.dart';
import '../../../constant.dart';
import 'package:intl/intl.dart';

import 'addNewOrder.dart';
import 'package:http/http.dart' as http;
class offlinePO_View extends StatefulWidget {
  List item;
  offlinePO_View({required this.item,Key? key}) : super(key: key);

  @override
  _offlinePO_ViewState createState() => _offlinePO_ViewState();
}

class _offlinePO_ViewState extends State<offlinePO_View> {
  final dateController = TextEditingController();
  bool isVisible = false;
  String? clientUrl;
  List poList = [];
  List temppoList = [];
  // List? poList;
  String jsonString = "";
  @override
  void initState() {

    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
      } else {
        kMainColor = Colors.red;
      }
    });

    //openHiveBox();

    // TODO: implement initState
    PreferenceManager.instance
        .getStringValue("accessToken")
        .then((value) => setState(() {
      token = Uri.encodeComponent(value.toString());
      log(token);
    }));

    PreferenceManager.instance
        .getStringValue("distributorId")
        .then((value) => setState(() {
      userId = value;
    }));
    PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) => setState(() {
      coCode = value;
    }));
    PreferenceManager.instance
        .getStringValue("ClintUrl")
        .then((value) => setState(() {
      clientUrl = value;
      // fetchData();
      print(value);
    }));
    super.initState();
    // openHiveBox();
  }

  Future<List<PurchaseOrder>> fetchData() async {
    // Fetch JSON data
    String jsonString1 = jsonString.toString();
    List<dynamic> jsonList = json.decode(jsonString);

    // Parse JSON data into a list of Item objects
    List<PurchaseOrder> items =
    jsonList.map((json) => PurchaseOrder.fromJson(json)).toList();
    return items;
  }

  openHiveBox() async {
    var box = await Hive.openBox('poList');
    var bookmark = box.get('poList');
    temppoList = bookmark;
    poList = temppoList;
    setState(() {
      poList = temppoList
          .where((item) =>
          item["PO_Status"].toLowerCase().contains("Draft".toLowerCase()))
          .toList();
    });
  }

  String? dateShow;
  Widget button({
    required String text,
    required int index,
  }) {
    return Flexible(
      child: InkWell(
        splashColor: Colors.cyanAccent,
        onTap: () {
          setState(() {
            _selectedValueIndex = index;
            if (_selectedValueIndex == 0) {
              poList = temppoList
                  .where((item) => item["PO_Status"]
                  .toLowerCase()
                  .contains("Draft".toLowerCase()))
                  .toList();
              //customerTicketData(Recordlength, selectedType, Status, searchText);
            }
            if (_selectedValueIndex == 1) {
              setState(() {
                poList = temppoList
                    .where((item) =>
                item["PO_Status"]
                    .toLowerCase()
                    .contains("RSM_Approved".toLowerCase()) ||
                    item["PO_Status"]
                        .toLowerCase()
                        .contains("Reject".toLowerCase()) ||
                    item["PO_Status"]
                        .toLowerCase()
                        .contains("RSM Approval".toLowerCase()))
                    .toList();
                // isDateVisible = false;
                //  customerTicketData(Recordlength, selectedType, Status, searchText);
              });
            }
            if (_selectedValueIndex == 2) {
              poList = temppoList
                  .where((item) => item["PO_Status"]
                  .toLowerCase()
                  .contains("Demo".toLowerCase()))
                  .toList();

              //customerTicketData(Recordlength, selectedType, Status, searchText);
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.black, width: 1.1),
              color: index == _selectedValueIndex
                  ? Color(0xFF4CCEFA)
                  : Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: index == _selectedValueIndex
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List list = [];
  var Id, ticketURN;
  var response1;
  var isLoading = false;
  var Status;
  var textController;
  final List<String> recordlength = [
    '10',
    '25',
    '50',
    '100',
  ];
  late String Recordlength = "10";
  // ignore: non_constant_identifier_names
  final Type = <String>[
    'All',
    'Feature Request',
    'Technical Assistance',
    'Visit Request'
  ];
  String selectedType = 'All';
  var searchText;

  List<String> buttonText = ["Draft", "In Process", "Completed"];
  int _selectedValueIndex = 0;

  String age = '';
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    CheckUserConnection();
    String dateStr = DateFormat.yMMMEd().format(now);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Purchase Order',
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
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  /* poList == [] || poList.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      :*/ Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  title: Text("Total PO Cart Items : ${widget.item.length}"),
                                ),
                              )
                          ),
                          Expanded(
                              child:ListView.builder(
                                  itemCount: widget.item.length,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) {
                                    return Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Container(
                                          // height: 65,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 5),
                                          child: ListTile(
                                            title: Text(widget.item![index].itName.toString(),),
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("QTY: "+widget.item![index].quantity.toString()),
                                                Text("UOM: "+widget.item![index].uom.toString(),),
                                              ],
                                            ),
                                            onTap: () {
                                              // Handle tap on drawer item
                                             // Navigator.pop(context); // Close the drawer
                                              // You can add additional functionality here when an item is tapped
                                            },
                                          ),
                                        ));
                                  })
                            )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool ActiveConnection = false;
  String T = "";
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

  var token, coCode, userId;

  Future<void> submit() async {
    setState(() {
      isLoading = true;
    });
    var BODYDATA = {
      "Json":jsonString.toString(),
    };
    final response = await http.post(
      Uri.parse("${clientUrl}Mobile/Mob_PO_Synch"),
      body: BODYDATA,
    );
    log("Api Name: $clientUrl/Mobile/Mob_PO_Synch $BODYDATA");
    log("Response Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var map = Map<String, dynamic>.from(jsonData);
      var DoPandingListData = PosyncResponse.fromJson(map);
      if (DoPandingListData.settings.success == "1") {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("POLISTJSON");
        poList.clear();
        Fluttertoast.showToast(
            msg: DoPandingListData.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        // Fluttertoast.showToast(
        //   msg: DoPandingListData.settings.message,
        //   textColor: Colors.white,
        //   backgroundColor: Colors.green,
        //   gravity: ToastGravity.CENTER,
        // );
      } else {

        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "${DoPandingListData.message}",
          textColor: Colors.white,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Please try again!",
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER,
      );
    }
  }

}
