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

import 'RSM_Order_List.dart';

class RSMOrderApprovalMainScreen extends StatefulWidget {
  RSMOrderApprovalMainScreen({Key? key}) : super(key: key);

  @override
  _RSMOrderApprovalMainScreenState createState() =>
      _RSMOrderApprovalMainScreenState();
}

class _RSMOrderApprovalMainScreenState
    extends State<RSMOrderApprovalMainScreen> {
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
  var distributorName;
  var pendingCount;
  var inHoldCount;
  var completedCount;
  var distributor_id;

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
                  Divider(),
                   distributorDataList.length < 0 || distributorDataList.isEmpty ? CircularProgressIndicator() :
                  Container(
                    height: MediaQuery.of(context).size.height* 0.30,
                    child: ListView.builder(
                                    itemCount: distributorDataList.length,
                                    itemBuilder: (context, index) {

                     distributorData = distributorDataList[index];
                     distributorName = distributorData['Distributor_Name'];
                    var mobileNo = distributorData['Mobile_No'];
                    var imgSrc = distributorData['img_src'];
                    pendingCount = distributorData['Pending_count'];
                    inHoldCount = distributorData['In_Hold_count'];
                    completedCount = distributorData['Completed_count'];
                    distributor_id = distributorData['id'];
                    return
                    Card(
                      color: Colors.white,
                      // Define the shape of the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // Define how the card's content should be clipped
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // Define the child widget of the card
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.
                        start,
                        children: <Widget>[
                          // Add padding around the row widget
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.
                              start,
                              children: <Widget>[
                                // Add an image widget to display an image
                                Container(
                                  height: MediaQuery
                                      .
                                  of(context)
                                      .
                                  size
                                      .height * 0.20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            foregroundImage: AssetImage(
                                              "images/logo.png",),
                                            minRadius: 40,
                                            maxRadius: 40,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          //'1',
                                          distributorName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500
                                          ),
                                          // style: MyTextSample.title(context)!.copyWith(
                                          //   color: Colors.grey,
                                          // ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          //'1',
                                          mobileNo,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500
                                          ),
                                          // style: MyTextSample.title(context)!.copyWith(
                                          //   color: Colors.grey,
                                          // ),
                                        ),
                                      ),
                                    ],),
                                ),

                                // Add some spacing between the image and the text
                                Container(width: 20),
                                // Add an expanded widget to take up the remaining horizontal space
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Add some spacing between the top of the card and the title
                                      Container(height: 5),
                                      // Add a title widget

                                      // Add some spacing between the title and the subtitle
                                      Container(height: 5),
                                      // Add a subtitle widget
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => RSMOrderListScreen(status: "completed",distributor_id: distributor_id,),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green, // Background color
                                                    borderRadius: BorderRadius.circular(
                                                        8.0), // Optional: You can adjust the border radius
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(6.0),
                                                    child: Text(
                                                      "Approved",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white, // Text color
                                                        fontWeight: FontWeight
                                                            .bold, // Bold text
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  //'3',
                                                  completedCount.toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => RSMOrderListScreen(status: "RSM Approval",distributor_id: distributor_id),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue, // Background color
                                                    borderRadius: BorderRadius.circular(
                                                        8.0), // Optional: You can adjust the border radius
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(6.0),
                                                    child: Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white, // Text color
                                                        fontWeight: FontWeight
                                                            .bold, // Bold text
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  //'2',
                                                  pendingCount.toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Add some spacing between the subtitle and the text
                                      Container(height: 10),
                                      // Add a text widget to display some text
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => RSMOrderListScreen(status: "Hold",distributor_id: distributor_id),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    // Background color
                                                    borderRadius: BorderRadius.circular(
                                                        8.0), // Optional: You can adjust the border radius
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(6.0),
                                                    child: Text(
                                                      "In-Hold",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white, // Text color
                                                        fontWeight: FontWeight
                                                            .bold, // Bold text
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  //'1',
                                                  inHoldCount.toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red, // Background color
                                                  borderRadius: BorderRadius.circular(
                                                      8.0), // Optional: You can adjust the border radius
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Text(
                                                    "Rejected",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white, // Text color
                                                      fontWeight: FontWeight
                                                          .bold, // Bold text
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "0",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                     );
                                    }
                                      ),
                  )
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

  var token, coCode, userId;

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
      "User_Id":userId,
      "Access_Token":token
    };

    print("${clientUrl}EntryList/Get_RSM_User_List_Approval$payload");
    var res = await dio.get("${clientUrl}EntryList/Get_RSM_User_List_Approval",
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
        // var box = Hive.box('poList');
        // box.put('poList', json['message']);
        // await Hive.openBox('poList');
        // poList =box.get('poList');
        // log("POLIST"+poList.toString());
         rawDataList = json['message'];
         setState(() {
           distributorDataList = rawDataList.cast<Map<String, dynamic>>();
         });
        // var distributorName = distributorData['Distributor_Name'];
        // var mobileNo = distributorData['Mobile_No'];
        // var imgSrc = distributorData['img_src'];
        // var pendingCount = distributorData['Pending_count'];
        // var inHoldCount = distributorData['In_Hold_count'];
        // var completedCount = distributorData['Completed_count'];
        for(var i = 0; i < json['message'].length; i++) {

          if (json['message'][i]['PO_Status']=="Draft"){
            //   poList = json['message'];
          }
          // children.add(new ListTile());
        }
      }

      setState(() {
        isLoading=false;
      });
      log(poList.toString());

    } else {
      setState(() {
        isLoading=false;
      });
      // show error
      print("Try Again");
    }
  }


}
