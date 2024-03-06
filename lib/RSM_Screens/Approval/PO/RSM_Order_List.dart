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
import '../../../Screens/Authentication/sign_in.dart';
import '../../../constant.dart';
import 'package:intl/intl.dart';

import 'POEditPage.dart';

class RSMOrderListScreen extends StatefulWidget {
  final String status;
  final String distributor_id;

  RSMOrderListScreen({
    required this.status,
    required this.distributor_id,
    Key? key}) :
        super(key: key);



  @override
  _RSMOrderListScreenState createState() =>
      _RSMOrderListScreenState();
}

class _RSMOrderListScreenState
    extends State<RSMOrderListScreen> {
  final dateController = TextEditingController();
  bool isVisible = false;
  String? clientUrl;

  List poList = [];
  List temppoList = [];
  var _currentSelectedValue = "Draft";
  var _currencies = [
    "Draft",
    "In Process",
    "Completed",
  ];
  List<Map<String, dynamic>> distributorDataList = [];
  List<dynamic> rawDataList =[];
  var distributorData;
  var poNo;
  var poDate;
  var totalAmount;
  var remarks;
  var createdBy;
  var pendingCount;
  var inHoldCount;
  var completedCount;

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
  void initState() {
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
      } else {
        kMainColor = Colors.red;
      }
    });

    openHiveBox();

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
        .then((value) => setState((){
      clientUrl = value;
      fetchData();
      print(value);
    }));
    super.initState();
    openHiveBox();
  }

  openHiveBox() async {
    var box = await Hive.openBox('poList');
    var bookmark = box.get('poList');
    //temppoList = bookmark;
    poList = temppoList;
    setState(() {
      poList = temppoList
          .where((item) =>
          item["PO_Status"].toLowerCase().contains("Draft".toLowerCase()))
          .toList();
    });
  }

  String? dateShow;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

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
          'Order Approval',
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
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: Container(
                  padding:  EdgeInsets.all(20.0),
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoSearchTextField(
                          //controller: controller,
                          onChanged: (value) {
                            setState(() {

                            });
                            poList = temppoList
                                .where((item) =>
                                item["PO_Status"].toLowerCase().contains(value.toLowerCase()))
                                .toList();
                          },
                          onSubmitted: (value) {},

                          autocorrect: true,
                        ),

                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: distributorDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              distributorData = distributorDataList[index];
                              poNo = distributorData['URN_NO'];
                              poDate = distributorData['cur_date'];
                              createdBy = distributorData['Created_by'];
                              remarks = distributorData['Remarks_dealer'];
                              totalAmount = distributorData['Order_Total'];
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child: Dismissible(
                                      background: Container(
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.green,
                                        ),
                                        child:  Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                      ),
                                      key: UniqueKey(),
                                      // direction: DismissDirection.startToEnd,
                                      onDismissed: (direction) {
                                        if (direction ==
                                            DismissDirection.startToEnd) {
                                          setState(() {});
                                        } else {
                                          setState(() {});
                                        }
                                      },
                                      secondaryBackground: Container(
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.red,
                                        ),
                                        child:  Icon(
                                          Icons.delete,
                                          size: 20,
                                        ),
                                      ),
                                      child: Container(
                                        child: Material(
                                          elevation: 2.0,
                                          child: Container(
                                            width: context.width(),
                                            // padding:  EdgeInsets.all(
                                            //     10.0),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: _selectedValueIndex ==
                                                      0
                                                      ? Colors.red
                                                      : _selectedValueIndex ==
                                                      1
                                                      ? Colors.blue
                                                      : Colors.green,
                                                  width: 3.0,
                                                ),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: ListTile(
                                              onTap: () {},
                                              title: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Column(

                                                    // mainAxisAlignment:
                                                    // MainAxisAlignment
                                                    //     .start,
                                                    // crossAxisAlignment:
                                                    // CrossAxisAlignment
                                                    //     .start,
                                                    children: [
                                                      Row(
                                                          children: [
                                                            ///////////
                                                            Flexible(
                                                              child: Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.only(
                                                                        bottomLeft:
                                                                        Radius.circular(0)),
                                                                    // color: Colors.grey,
                                                                  ),
                                                                  alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                                  child: Column(
                                                                    children:  [
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.all(0.0),
                                                                        child:
                                                                        Text(
                                                                          "",
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                            Flexible(
                                                              child: Container(
                                                                  height: 25,
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                                                                      color: Colors.red
                                                                    // color: poList[index]['PO_Status'] ==
                                                                    //     "Draft"
                                                                    //     ? Colors
                                                                    //     .red:poList[index]['PO_Status'] ==
                                                                    //     "RSM Approval"
                                                                    //     ? Colors
                                                                    //     .grey:poList[index]['PO_Status'] ==
                                                                    //     "Hold"
                                                                    //     ?Colors.blue:poList[index]['PO_Status'] ==
                                                                    //     "Reject"
                                                                    //     ?Colors.orange:poList[index]['PO_Status'] ==
                                                                    //     "1"?Colors.green:Colors.yellow,
                                                                  ),

                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                        left:
                                                                        0),
                                                                    child: Text(
                                                                        widget.status,
                                                                        style: TextStyle(
                                                                            color:/* poList[index]['PO_Status'] ==
                                                                                "Draft"
                                                                                ? Colors
                                                                                .red:poList[index]['PO_Status'] ==
                                                                                "RSM Approval"
                                                                                ? Colors
                                                                                .grey:poList[index]['PO_Status'] ==
                                                                                "Hold"
                                                                                ?Colors.blue:poList[index]['PO_Status'] ==
                                                                                "Reject"
                                                                                ?Colors.orange:*/Colors.white,
                                                                            fontSize: 15,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                  )),
                                                            ),
                                                            PopupMenuButton(
                                                              itemBuilder: (ctx) => [
                                                                _buildPopupMenuItem(Icons.edit,'Edit'),
                                                                _buildPopupMenuItem(Icons.history,'Order History'),
                                                                _buildPopupMenuItem(Icons.remove_red_eye,'View'),
                                                                _buildPopupMenuItem(Icons.delete,'Delete'),

                                                              ],
                                                            ),

                                                          ]
                                                      ),

                                                      Row(
                                                        children: [
                                                          ///////////
                                                          Flexible(
                                                            child: Container(
                                                                decoration:  BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                  // color: Colors.grey,
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  children:  [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.all(5.0),
                                                                      child:
                                                                      Text(
                                                                        "PO NO",
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
                                                                child:  Padding(
                                                                  padding:
                                                                  EdgeInsets.only(left: 10),
                                                                  child:
                                                                  Text(
                                                                    poNo,
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black,
                                                                        fontSize: 16),
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
                                                                decoration:  BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                  // color: Colors.grey,
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  children:  [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.all(5.0),
                                                                      child:
                                                                      Text(
                                                                        "Purchase Date",
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
                                                                child:  Padding(
                                                                  padding:
                                                                  EdgeInsets.only(left: 10),
                                                                  child:
                                                                  Text(
                                                                    poDate,
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black,
                                                                        fontSize: 16),
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
                                                                decoration:  BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                  // color: Colors.grey,
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  children:  [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.all(5.0),
                                                                      child:
                                                                      Text(
                                                                        "Created By",
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
                                                                child:   Padding(
                                                                  padding:
                                                                  EdgeInsets.only(left: 10),
                                                                  child:
                                                                  Text(
                                                                    createdBy,
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color:Colors.black,
                                                                        fontSize: 16),
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
                                                                decoration:  BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                  // color: Colors.grey,
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  children:  [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.all(5.0),
                                                                      child:
                                                                      Text(
                                                                        "Remarks",
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
                                                                child:  Padding(
                                                                  padding:
                                                                  EdgeInsets.only(left: 10),
                                                                  child:
                                                                  Text(
                                                                    remarks,
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black,
                                                                        fontSize: 16),
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
                                                                decoration:  BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                  // color: Colors.grey,
                                                                ),
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  children:  [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.all(5.0),
                                                                      child:
                                                                      Text(
                                                                        "Total Amount",
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
                                                                child:  Padding(
                                                                  padding:
                                                                  EdgeInsets.only(left: 10),
                                                                  child:
                                                                  Text(
                                                                    totalAmount.toString(),
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black,
                                                                        fontSize: 16),
                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),

                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),


                )

            )
          ]
      ),
    );
  }
  bool ActiveConnection = false;
  String T = "";
  var token, coCode, userId;

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

  Future<void> fetchData() async {
    //clientUrl="https://demo.datanote.co.in/urminapi/";
    /*   isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId").toString();
    token = Uri.encodeComponent(prefs.getString("token").toString());
    co_code = prefs.getString("co_code").toString();*/
    PreferenceManager.instance
        .getStringValue("accessToken")
        .then((value) => setState(() {
      token = value.toString();
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

    isLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      //"Co_Code":coCode,
      "UR_CODE":userId,
      "Status":widget.status,
      "Access_Token":token
    };

    print("${clientUrl}EntryList/Get_RSM_Approval_List$payload");
    var res = await dio.get("${clientUrl}EntryList/Get_RSM_Approval_List",
        //data: formData,
        queryParameters: payload,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    print('---- status code: ${res.statusCode}');
    setState(() {
      isLoading=false;
    });
    if (res.statusCode == 200) {
      /*     isLoading = false;*/
      var json = jsonDecode(res.data);
      print(json);
      log("OtpRES" + json['message'].toString());
      if (json['message'].toString() == "User Id or Token is Invalid.") {
        Fluttertoast.showToast(
            msg: "LogOut",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.push(
        // context,
        // MaterialPageRoute(builder: (context) =>  SignIn()),
        // );
      }else{

        setState(() {
          isLoading=false;
        });

        rawDataList = json['message'];
        setState(() {
          distributorDataList = rawDataList.cast<Map<String, dynamic>>();

        });

        // var mobileNo = distributorData['Mobile_No'];
        // var imgSrc = distributorData['img_src'];
        // var pendingCount = distributorData['Pending_count'];
        // var inHoldCount = distributorData['In_Hold_count'];
        // var completedCount = distributorData['Completed_count'];
        for(var i = 0; i < json['message'].length; i++) {


          // children.add(new ListTile());
        }
      }

      setState(() {
        isLoading=false;
      });
      //log(poList.toString());

    } else {
      setState(() {
        isLoading=false;
      });
      // show error
      print("Try Again");
    }
  }

  PopupMenuItem _buildPopupMenuItem(IconData icon, String title) {
    return PopupMenuItem(
      height: 50, // Set a fixed height
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          if (title == 'Edit') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => POEditPage(distributor_id: widget.distributor_id,),
              ),
            );
          }
          // Handle other menu items here
        },
      ),
    );
  }

}