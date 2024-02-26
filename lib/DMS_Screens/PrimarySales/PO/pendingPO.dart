// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:maan_hrm/DMS_Screens/PrimarySales/PO/offlinePO_View.dart';
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

class pendingPO extends StatefulWidget {
  pendingPO({Key? key}) : super(key: key);

  @override
  _pendingPOState createState() => _pendingPOState();
}

class _pendingPOState extends State<pendingPO> {
  final dateController = TextEditingController();
  bool isVisible = false;
  String? clientUrl;
  List poList = [];
  List temppoList = [];
  // List? poList;
  String jsonString = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      poList = prefs.getStringList("POLISTJSON") ?? [];
      // poList= jsonEncode(poList1);
      log(poList.toList().toString());
      jsonString = "${poList.toString()}";
      log(jsonString.toString());
      var jsonList = json.decode(jsonString);

      // Parse JSON data into a list of Item objects
      items = jsonList.map((json) => PurchaseOrder.fromJson(json)).toList();

      //fetchData();
    });
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
        kMainColor = Color(0xFF2957a4);
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

  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time); // Formats time in "h:mm a" format
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
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

  List<PurchaseOrder> list = [];
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
  List items = [];
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
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: kMainColor,
      //   elevation: 0.0,
      //   titleSpacing: 0.0,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: Text(
      //     'Purchase Order',
      //     maxLines: 2,
      //     style: kTextStyle.copyWith(
      //         color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   actions: [
      //     ActiveConnection
      //         ? Container()
      //         : Padding(
      //             padding: EdgeInsets.only(right: 20.0),
      //             child: Image(
      //               color: Colors.white,
      //               height: 30,
      //               width: 30,
      //               image: AssetImage('images/wifi.png'),
      //             ),
      //           ),
      //   ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        // height: 65,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: ListTile(
                          leading: Icon(CupertinoIcons.cart),
                          title: Text("Total Pending PO: ${poList.length}"),
                        ),
                      )),
                  /* poList == [] || poList.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      :*/
                  items!.length != 0
                      ? Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: items!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Slidable(
                                                  startActionPane: ActionPane(
                                                    motion: BehindMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    offlinePO_View(
                                                                        item: items![index]
                                                                            .item),
                                                              ));
                                                        },
                                                        backgroundColor:
                                                            Colors.green,
                                                        icon: Icons.edit,
                                                        label: 'Edit',
                                                      ),
                                                      SlidableAction(
                                                        onPressed: (context) {},
                                                        backgroundColor:
                                                            Colors.blue,
                                                        icon: Icons
                                                            .timelapse_outlined,
                                                        label: 'Order History',
                                                      ),
                                                    ],
                                                  ),
                                                  endActionPane: ActionPane(
                                                    motion: BehindMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {},
                                                        backgroundColor:
                                                            Colors.blue,
                                                        icon: Icons
                                                            .remove_red_eye,
                                                        label: 'View',
                                                      ),
                                                      SlidableAction(
                                                        onPressed: (context) {},
                                                        backgroundColor:
                                                            Colors.red,
                                                        icon: Icons.delete,
                                                        label: 'Delete',
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: Material(
                                                        elevation: 2.0,
                                                        child: Container(
                                                          width:
                                                              context.width(),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              left: BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 3.0,
                                                              ),
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        offlinePO_View(
                                                                            item: items![index].item),
                                                                  ));
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      ///////////
                                                                      Flexible(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                              // color: Colors.grey,
                                                                            ),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(0.0),
                                                                                  child: Text(
                                                                                    "",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Flexible(
                                                                        child: Container(
                                                                            height: 25,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                                                                              color: Colors.red,
                                                                            ),
                                                                            alignment: Alignment.center,
                                                                            child: const Padding(
                                                                              padding: EdgeInsets.only(left: 0),
                                                                              child: Text("Pending",
                                                                                  style: TextStyle(
                                                                                      color: /* poList[index]['PO_Status'] ==
                                                                                    "Draft"
                                                                                    ? Colors
                                                                                    .red:poList[index]['PO_Status'] ==
                                                                                    "RSM Approval"
                                                                                    ? Colors
                                                                                    .grey:poList[index]['PO_Status'] ==
                                                                                    "Hold"
                                                                                    ?Colors.blue:poList[index]['PO_Status'] ==
                                                                                    "Reject"
                                                                                    ?Colors.orange:*/
                                                                                          Colors.white,
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.bold)),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ///////////
                                                                      Flexible(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                              // color: Colors.grey,
                                                                            ),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    "PO No",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Flexible(
                                                                        child: Container(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                index.toString(),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ///////////
                                                                      Flexible(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                              // color: Colors.grey,
                                                                            ),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    "Order Total",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Flexible(
                                                                        child: Container(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                items[index].orderTotal.toString(),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ///////////
                                                                      Flexible(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                              // color: Colors.grey,
                                                                            ),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    "PO Date",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Flexible(
                                                                        child: Container(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                _formatDateTime(items[index].curDate).toString(),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ///////////
                                                                      Flexible(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                              // color: Colors.grey,
                                                                            ),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    "PO Time",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Flexible(
                                                                        child: Container(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                _formatTime(items[index].curTime) /*items[index].curTime.toString(),*/,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            /*trailing: InkWell(
                                                          onTap: () {
                                                            //OrderDetailsPage().launch(context);
                                                          },
                                                          child: Text(
                                                              poList[index]['PO_Status'],
                                                              style: TextStyle(
                                                                  color: poList[index]['PO_Status'] ==
                                                                              "Draft"
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .green,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),*/
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          );
                                        }))
                              ]),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: context.width(),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image(
                                      height: 200,
                                      width: 200,
                                      image: AssetImage('images/empty.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    children: [

                                      Text(
                                        "Pending PO's are not available!!",
                                        style: kTextStyle.copyWith(
                                          fontSize: 15,
                                            color: kGreyTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 0.0, left: 10, right: 10),
                  child: Container(
                      //width: double.infinity,
                      child: ElevatedButton(
                    child: Text('Place Order',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      if (ActiveConnection == true) {
                        if (poList.length != 0) {
                          log(jsonString);
                          submit();
                        } else {
                          Fluttertoast.showToast(
                              msg: "All PO's are already sync !",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "You are offline!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(kMainColor)),
                  )),
                ),
              ),
              CircleAvatar(
                backgroundColor: kMainColor,
                child: IconButton(
                  onPressed: () {
                    /*showDialog(
                      context: context,
                      builder: (context) => attachmentClass(),
                    );*/
                    //urnData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addNewOrderForPo(),
                        ));
                  },
                  icon: Icon(CupertinoIcons.add),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!mounted) return;
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
          kMainColor = Color(0xFF2957a4);
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
      "Json": jsonString.toString(),
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
        items.clear();
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
