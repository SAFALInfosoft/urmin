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
import '../../../Screens/Authentication/sign_in.dart';
import '../../../constant.dart';
import 'package:intl/intl.dart';

import '../PRIMARY_SALES_MENU.dart';
import 'addNewOrder.dart';

class purchaseOrderMainScreen extends StatefulWidget {
   purchaseOrderMainScreen({Key? key}) : super(key: key);

  @override
  _purchaseOrderMainScreenState createState() =>
      _purchaseOrderMainScreenState();
}

class _purchaseOrderMainScreenState extends State<purchaseOrderMainScreen> {
  final dateController = TextEditingController();
  bool isVisible = false;
  String? clientUrl;

  List poList = [];
  List temppoList = [];
  var _currentSelectedValue="Draft";
  var _currencies = [
    "Draft",
    "In Process",
    "Completed",
  ];
  var _statusSelectedValue="RSM Approval";
  var _status =[
    "Reject",
    "RSM Approval",
    "Hold",
    "1"
  ];
  @override
  void initState() {
    CheckUserConnection().then((value) {
      if(ActiveConnection==true){

      }else{
        kMainColor=Colors.red;
      }
    });

    openHiveBox();

    // TODO: implement initState
    PreferenceManager.instance
        .getStringValue("accessToken")
        .then((value) => setState(() {
      token =Uri.encodeComponent(value.toString());
      log(token);
    }));
    PreferenceManager.instance
        .getStringValue("distributorId")
        .then((value) => setState(() {
      userId =value;
    }));
    PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) => setState(() {
      coCode =value;
    }));
    PreferenceManager.instance
        .getStringValue("ClintUrl")
        .then((value) => setState(() {
              clientUrl = value;
             // fetchData();
              print(value);
            }));
    super.initState();
    openHiveBox();

  }
  openHiveBox() async {
    var box = await Hive.openBox('poList');
    var bookmark = box.get('poList');
    temppoList=bookmark;
    poList= temppoList;
    setState(() {
      poList = temppoList
          .where((item) => item["PO_Status"]
          .toLowerCase()
          .contains("Draft".toLowerCase()))
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
                    .where((item) => item["PO_Status"]
                    .toLowerCase().contains("RSM_Approved".toLowerCase()) ||
                    item["PO_Status"].toLowerCase().contains("Reject".toLowerCase())||
                    item["PO_Status"].toLowerCase().contains("RSM Approval".toLowerCase()))
                    .toList();
                // isDateVisible = false;
                //  customerTicketData(Recordlength, selectedType, Status, searchText);
              });
            }
            if (_selectedValueIndex == 2) {
              poList = temppoList
                  .where((item) => item["PO_Status"]
                  .toLowerCase().contains("Demo".toLowerCase()) )
                  .toList();

              //customerTicketData(Recordlength, selectedType, Status, searchText);
            }
          });
        },
        child: Padding(
          padding:  EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.black, width: 1.1),
              color: index == _selectedValueIndex
                  ? Color(0xFF4CCEFA)
                  : Colors.white,
            ),
            child: Padding(
              padding:  EdgeInsets.all(8.0),
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
    return WillPopScope(
      onWillPop: ()async{
        return await Navigator.push(context,  MaterialPageRoute(builder: (context) =>
            PRIMARY_SALES_MENU()));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: kMainColor,
        //   elevation: 0.0,
        //   titleSpacing: 0.0,
        //   iconTheme:  IconThemeData(color: Colors.white),
        //   title: Text(
        //     'Purchase Order',
        //     maxLines: 2,
        //     style: kTextStyle.copyWith(
        //         color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   actions:  [
        //     ActiveConnection?Container():Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: Image(
        //         color: Colors.white,
        //         height: 30,
        //         width: 30,
        //         image: AssetImage('images/wifi.png'),
        //       ),
        //     ),
        //   ],
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding:  EdgeInsets.all(8.0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.only(left: 10, right: 0),

                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return Container(
                                    //width: MediaQuery.of(context).size.width! * 0.90,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                                        /*contentPadding:
                                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),*/
                                        isDense: true,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'Please select Status',
                                        labelStyle: TextStyle(
                                            color: Colors.green),
                                        hintStyle: TextStyle(
                                            color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                      isEmpty: _currentSelectedValue == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          icon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color:  Colors.blueAccent,
                                          ),
                                          hint: Text(
                                            'Please select status',
                                            style: TextStyle(
                                                color: Colors.blue),
                                          ),
                                          value: _currentSelectedValue,
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _currentSelectedValue = newValue!;
                                              state.didChange(newValue);
                                              setState(() {
                                                //_selectedValueIndex = index;
                                                if (_currentSelectedValue == "Draft") {
                                                  poList = temppoList
                                                      .where((item) => item["PO_Status"]
                                                      .toLowerCase()
                                                      .contains("Draft".toLowerCase()))
                                                      .toList();
                                                }
                                                if (_currentSelectedValue == "In Process") {
                                                  setState(() {
                                                    poList = temppoList
                                                        .where((item) => item["PO_Status"]
                                                        .toLowerCase().contains("RSM_Approved".toLowerCase()) ||
                                                        item["PO_Status"].toLowerCase().contains("Reject".toLowerCase())||
                                                        item["PO_Status"].toLowerCase().contains("RSM Approval".toLowerCase())||
                                                        item["PO_Status"].toLowerCase().contains("Hold".toLowerCase())||
                                                        item["PO_Status"].toLowerCase().contains("1".toLowerCase()))
                                                        .toList();
                                                    });
                                                }
                                                if (_currentSelectedValue == "Completed") {
                                                  poList = temppoList
                                                      .where((item) => item["PO_Status"]
                                                      .toLowerCase().contains("....Demoo".toLowerCase()) )
                                                      .toList();
                                                }
                                              });
                                            });
                                          },
                                          items: _currencies.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text("${value}"),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 5, right: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {});
                                if (isVisible == true) {
                                  isVisible = false;
                                } else {
                                  isVisible = true;
                                }
                              },
                              child: Container(
                                //width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border:
                                  Border.all(color: Colors.black, width: 1.1),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                    padding:  EdgeInsets.all(11.0),
                                    child: Text(poList.length.toString())),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.5,right: 12.5),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return Container(
                                  //width: MediaQuery.of(context).size.width! * 0.90,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                                      /*contentPadding:
                                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),*/
                                      isDense: true,
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      hintText: 'Please select Status',
                                      labelStyle: TextStyle(
                                          color: Colors.green),
                                      hintStyle: TextStyle(
                                          color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    isEmpty: _statusSelectedValue == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color:  Colors.blueAccent,
                                        ),
                                        hint: Text(
                                          'Please select status',
                                          style: TextStyle(
                                              color: Colors.blue),
                                        ),
                                        value: _statusSelectedValue,
                                        isDense: true,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _statusSelectedValue = newValue!;
                                            state.didChange(newValue);
                                            setState(() {
                                              //_selectedValueIndex = index;
                                              if (_statusSelectedValue == "RSM Approval") {
                                                poList = temppoList
                                                    .where((item) => item["PO_Status"]
                                                    .toLowerCase()
                                                    .contains("RSM Approval".toLowerCase()))
                                                    .toList();
                                              }
                                              if (_statusSelectedValue == "In Process") {
                                                setState(() {
                                                  poList = temppoList
                                                      .where((item) => item["PO_Status"]
                                                      .toLowerCase().contains("RSM_Approved".toLowerCase()) ||
                                                      item["PO_Status"].toLowerCase().contains("Reject".toLowerCase())||
                                                      item["PO_Status"].toLowerCase().contains("RSM Approval".toLowerCase())||
                                                      item["PO_Status"].toLowerCase().contains("Hold".toLowerCase())||
                                                      item["PO_Status"].toLowerCase().contains("1".toLowerCase()))
                                                      .toList();
                                                });
                                              }
                                              if (_statusSelectedValue == "Completed") {
                                                poList = temppoList
                                                    .where((item) => item["PO_Status"]
                                                    .toLowerCase().contains("....Demoo".toLowerCase()) )
                                                    .toList();
                                              }
                                            });
                                          });
                                        },
                                        items: _status.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text("${value}"),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 10.0,right: 10),
                      child: Row(
                        children: [
                          Expanded(
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
                          Padding(
                            padding:  EdgeInsets.only(left: 5, right: 0),
                            child: InkWell(
                              onTap: () {
                                setState(() {});
                                if (isVisible == true) {
                                  isVisible = false;
                                } else {
                                  isVisible = true;
                                }
                              },
                              child: Container(
                                //width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border:
                                  Border.all(color: Colors.black, width: 1.1),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child: Icon(Icons.date_range)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              textFieldType: TextFieldType.NAME,
                              readOnly: true,
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                dateController.text =
                                    date.toString().substring(0, 10);
                              },
                              controller: dateController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(
                                    Icons.date_range_rounded,
                                    color: kGreyTextColor,
                                  ),
                                  labelText: 'To Date',
                                  hintText: dateStr.toString()),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AppTextField(
                              textFieldType: TextFieldType.NAME,
                              readOnly: true,
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                dateController.text =
                                    date.toString().substring(0, 10);
                              },
                              controller: dateController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(
                                    Icons.date_range_rounded,
                                    color: kGreyTextColor,
                                  ),
                                  labelText: "From Date",
                                  hintText: dateStr),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                      poList==[]||poList.isEmpty?
                      Center(child:
                      Column(
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
                                      "PO not available!!",
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
                      )): Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: poList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                   // poList.sort((a, b) => a["cur_date"].compareTo(b["cur_date"]));
                                    return InkWell(
                                      onTap: () {},
                                      child: Padding(
                                          padding:  EdgeInsets.all(5.0),
                                          child: Slidable(
                                            startActionPane: ActionPane(
                                              motion:  BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {},
                                                  backgroundColor: Colors.green,
                                                  icon: Icons.edit,
                                                  label: 'Edit',
                                                ),
                                                SlidableAction(
                                                  onPressed: (context) {},
                                                  backgroundColor: Colors.blue,
                                                  icon: Icons.timelapse_outlined,
                                                  label: 'Order History',
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion:  BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {},
                                                  backgroundColor: Colors.blue,
                                                  icon: Icons.remove_red_eye,
                                                  label: 'View',
                                                ),
                                                SlidableAction(
                                                  onPressed: (context) {},
                                                  backgroundColor: Colors.red,
                                                  icon: Icons.delete,
                                                  label: 'Delete',
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Material(
                                                  elevation: 2.0,
                                                  child: Container(
                                                    width: context.width(),
                                                    padding:  EdgeInsets.all(
                                                        0.0),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide(
                                                          color: poList[index]['PO_Status'] ==
                                                              "Draft"
                                                              ? Colors
                                                              .red:poList[index]['PO_Status'] ==
                                                              "RSM Approval"
                                                              ? Colors
                                                              .grey:poList[index]['PO_Status'] ==
                                                              "Hold"
                                                              ?Colors.blue:poList[index]['PO_Status'] ==
                                                              "Reject"
                                                              ?Colors.orange:poList[index]['PO_Status'] ==
                                                              "1"?Colors.green:Colors.yellow,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    // child: Column(
                                                    //   children: [
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .end,
                                                    //       children: [
                                                    //         Flexible(
                                                    //           child: Container(
                                                    //             // width: MediaQuery.of(context).size.width / 2.5,
                                                    //               alignment:
                                                    //               Alignment
                                                    //                   .center,
                                                    //               decoration:
                                                    //               BoxDecoration(
                                                    //                 color:Colors.blueAccent,
                                                    //                 borderRadius: BorderRadius.only(
                                                    //                     topRight:
                                                    //                     Radius.circular(
                                                    //                         12),
                                                    //                     topLeft: Radius
                                                    //                         .circular(
                                                    //                         12)),
                                                    //               ),
                                                    //               child: Padding(
                                                    //                 padding:
                                                    //                  EdgeInsets
                                                    //                     .all(
                                                    //                     8.0),
                                                    //                 child: Text(
                                                    //                   "Status",
                                                    //                   //Approved
                                                    //                   overflow:
                                                    //                   TextOverflow
                                                    //                       .ellipsis,
                                                    //                   style:
                                                    //                    TextStyle(
                                                    //                     color: Colors
                                                    //                         .white,
                                                    //                     fontSize:
                                                    //                     18,
                                                    //                     fontWeight:
                                                    //                     FontWeight
                                                    //                         .bold,
                                                    //                   ),
                                                    //                 ),
                                                    //               )),
                                                    //         )
                                                    //       ],
                                                    //     ),
                                                    //      SizedBox(
                                                    //       height: 5,
                                                    //     ),
                                                    //     Container(
                                                    //       decoration:
                                                    //       BoxDecoration(
                                                    //         borderRadius:
                                                    //          BorderRadius
                                                    //             .only(
                                                    //             bottomLeft: Radius
                                                    //                 .circular(
                                                    //                 12),
                                                    //             bottomRight: Radius
                                                    //                 .circular(
                                                    //                 12)),
                                                    //         color:
                                                    //         Colors.grey[400],
                                                    //       ),
                                                    //       child: Column(
                                                    //         children: [
                                                    //           //Urn Number
                                                    //           Row(
                                                    //             children: [
                                                    //               ///////////
                                                    //               Flexible(
                                                    //                 child: Container(
                                                    //                     decoration:  BoxDecoration(
                                                    //                       borderRadius:
                                                    //                       BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                    //                       // color: Colors.grey,
                                                    //                     ),
                                                    //                     alignment: Alignment.centerRight,
                                                    //                     child: Column(
                                                    //                       children:  [
                                                    //                         Padding(
                                                    //                           padding:
                                                    //                           EdgeInsets.all(5.0),
                                                    //                           child:
                                                    //                           Text(
                                                    //                             "URN NUMBER",
                                                    //                             overflow: TextOverflow.ellipsis,
                                                    //                             style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ],
                                                    //                     )),
                                                    //               ),
                                                    //               Flexible(
                                                    //                 child: Container(
                                                    //                     alignment: Alignment.centerLeft,
                                                    //                     child:  Padding(
                                                    //                       padding:
                                                    //                       EdgeInsets.only(left: 10),
                                                    //                       child:
                                                    //                       Text(
                                                    //                         "Hii",
                                                    //                         overflow:
                                                    //                         TextOverflow.ellipsis,
                                                    //                         style: TextStyle(
                                                    //                             fontWeight: FontWeight.w400,
                                                    //                             color: Colors.black,
                                                    //                             fontSize: 16),
                                                    //                       ),
                                                    //                     )),
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //
                                                    //
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),

                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Padding(
                                                        padding:  EdgeInsets.only(left: 8.0),
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
                                                                       color: poList[index]['PO_Status'] ==
                                                                         "Draft"
                                                                         ? Colors
                                                                         .red:poList[index]['PO_Status'] ==
                                                                         "RSM Approval"
                                                                         ? Colors
                                                                         .grey:poList[index]['PO_Status'] ==
                                                                         "Hold"
                                                                         ?Colors.blue:poList[index]['PO_Status'] ==
                                                                         "Reject"
                                                                         ?Colors.orange:poList[index]['PO_Status'] ==
                                                                       "1"?Colors.green:Colors.yellow,
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
                                                                            poList[index]['PO_Status'] ==
                                                                                "RSM Approval"?"RSM Approval":poList[index]['PO_Status']=="RSM_Approved"?"Do Pending":poList[index]['PO_Status']=="HOld"?"Hold":poList[index]['PO_Status']=="1"?"DO Created":poList[index]['PO_Status'],
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
                                                                PopupMenuButton<int>(
                                                                  itemBuilder: (context) => [
                                                                    // PopupMenuItem 1
                                                                    PopupMenuItem(
                                                                      value: 1,
                                                                      // row with 2 children
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons.edit),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text("Edit")
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // PopupMenuItem 2
                                                                    PopupMenuItem(
                                                                      value: 2,
                                                                      // row with two children
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons.timelapse_outlined),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text("Order History")
                                                                        ],
                                                                      ),
                                                                    ),PopupMenuItem(
                                                                      value: 2,
                                                                      // row with two children
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons.remove_red_eye),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text("View")
                                                                        ],
                                                                      ),
                                                                    ),PopupMenuItem(
                                                                      value: 2,
                                                                      // row with two children
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons.delete),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text("Delete")
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  offset: Offset(0, 100),
                                                                  color: Colors.grey,
                                                                  elevation: 2,
                                                                  // on selected we show the dialog box
                                                                  onSelected: (value) {
                                                                    // if value 1 show dialog
                                                                    if (value == 1) {
                                                                    //  _showDialog(context);
                                                                      // if value 2 show dialog
                                                                    } else if (value == 2) {
                                                                     // _showDialog(context);
                                                                    }
                                                                  },
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
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Text(
                                                                              "PO No",
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                                left:
                                                                                    10),
                                                                        child: Text(
                                                                          poList[index]
                                                                              [
                                                                              'URN_NO'],
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  16),
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
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Text(
                                                                              "Date",
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                                left:
                                                                                    10),
                                                                        child: Text(
                                                                          poList[index]
                                                                              [
                                                                              'cur_date'],
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  16),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                            /*    Row(
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
                                                                      child:  Padding(
                                                                        padding:
                                                                        EdgeInsets.only(left: 10),
                                                                        child:
                                                                        Text(
                                                                          _selectedValueIndex ==
                                                                              0?' Self':"System",
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color:_selectedValueIndex ==
                                                                                  0? Colors
                                                                                  .blue:Colors.red,
                                                                              fontSize: 16),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),*/
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
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Text(
                                                                              "Order Value",
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                                left:
                                                                                    10),
                                                                        child: Text(
                                                                          poList[index]
                                                                                  [
                                                                                  'Final_total']
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  16),
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
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Text(
                                                                              "Boxes",
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                                left:
                                                                                    10),
                                                                        child: Text(
                                                                          poList[index]
                                                                                  [
                                                                                  'box']
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  16),
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
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Text(
                                                                              "Cartons",
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                                left:
                                                                                    10),
                                                                        child: Text(
                                                                          poList[index]
                                                                                  [
                                                                                  'Total_quantity']
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                                  16),
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
                                  }),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
          elevation: 10,
          backgroundColor: kMainColor,
          child:  Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
  bool ActiveConnection =false;
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
var token,coCode,userId;
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
       token =Uri.encodeComponent(value.toString());
      log(token);
    }));
 PreferenceManager.instance
        .getStringValue("distributorId")
        .then((value) => setState(() {
       userId =value;
    }));
 PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) => setState(() {
       coCode =value;
    }));


    isLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      "Co_Code":coCode,
      "User_Id":userId,
      "Access_Token":token
    };

    print("${clientUrl}EntryList/GetPoList$payload");
    var res = await dio.get("${clientUrl}EntryList/GetPoList",
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
        var box = Hive.box('poList');
        box.put('poList', json['message']);
        await Hive.openBox('poList');
        poList =box.get('poList');
        log("POLIST"+poList.toString());
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
