// ignore_for_file: library_private_types_in_public_api

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maan_hrm/Screens/Employee%20Overtime/empty_employee_overtime.dart';
import 'package:maan_hrm/Screens/Employee%20management/empty_employee.dart';
import 'package:maan_hrm/Screens/Leave%20Managemenr/leave_management.dart';
import 'package:maan_hrm/Screens/Reference%20Management/empty_reference.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/empty_salary_statement.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendance_employee_list.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../constant.dart';
import 'package:intl/intl.dart';

import 'addNewOrder.dart';

class purchaseOrderMainScreen extends StatefulWidget {
  const purchaseOrderMainScreen({Key? key}) : super(key: key);

  @override
  _purchaseOrderMainScreenState createState() =>
      _purchaseOrderMainScreenState();
}

class _purchaseOrderMainScreenState extends State<purchaseOrderMainScreen> {
  final dateController = TextEditingController();
  bool isVisible = false;

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
              Status = "open";
              //customerTicketData(Recordlength, selectedType, Status, searchText);
            }
            if (_selectedValueIndex == 1) {
              setState(() {
                Status = "close";
                // isDateVisible = false;
                //  customerTicketData(Recordlength, selectedType, Status, searchText);
              });
            }
            if (_selectedValueIndex == 2) {
              Status = "All";
              //customerTicketData(Recordlength, selectedType, Status, searchText);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.black, width: 1.1),
              color: index == _selectedValueIndex
                  ? Color(0xFF4CCEFA)
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
    log(now);
    String dateStr = DateFormat.yMMMEd().format(now);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Purchase Order',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  //Button Details
                  Row(
                    children: [
                      ...List.generate(
                        buttonText.length,
                        (index) => button(
                          index: index,
                          text: buttonText[index],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {

                            });
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
                                  const BorderRadius.all(Radius.circular(12)),
                              border:
                                  Border.all(color: Colors.black, width: 1.1),
                              color: Colors.white,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.date_range)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},

                      autocorrect: true,
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
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Slidable(
                                          startActionPane: ActionPane(
                                            motion: const BehindMotion(),
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
                                            motion: const BehindMotion(),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Material(
                                                elevation: 2.0,
                                                child: Container(
                                                  width: context.width(),
                                                  padding: const EdgeInsets.all(
                                                      10.0),
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
                                                  //                 const EdgeInsets
                                                  //                     .all(
                                                  //                     8.0),
                                                  //                 child: Text(
                                                  //                   "Status",
                                                  //                   //Approved
                                                  //                   overflow:
                                                  //                   TextOverflow
                                                  //                       .ellipsis,
                                                  //                   style:
                                                  //                   const TextStyle(
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
                                                  //     const SizedBox(
                                                  //       height: 5,
                                                  //     ),
                                                  //     Container(
                                                  //       decoration:
                                                  //       BoxDecoration(
                                                  //         borderRadius:
                                                  //         const BorderRadius
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
                                                  //                     decoration: const BoxDecoration(
                                                  //                       borderRadius:
                                                  //                       BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                  //                       // color: Colors.grey,
                                                  //                     ),
                                                  //                     alignment: Alignment.centerRight,
                                                  //                     child: Column(
                                                  //                       children: const [
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
                                                  //                     child: const Padding(
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

                                                  child: ListTile(
                                                    onTap: () {},
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            ///////////
                                                            Flexible(
                                                              child: Container(
                                                                  decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                    // color: Colors.grey,
                                                                  ),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Column(
                                                                    children: const [
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.all(5.0),
                                                                        child:
                                                                        Text(
                                                                          "URN NUMBER",
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
                                                                  child: const Padding(
                                                                    padding:
                                                                    EdgeInsets.only(left: 10),
                                                                    child:
                                                                    Text(
                                                                      "PO/001",
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
                                                                  decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                    // color: Colors.grey,
                                                                  ),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Column(
                                                                    children: const [
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.all(5.0),
                                                                        child:
                                                                        Text(
                                                                          "Date",
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
                                                                  child: const Padding(
                                                                    padding:
                                                                    EdgeInsets.only(left: 10),
                                                                    child:
                                                                    Text(
                                                                      "27/10/2023",
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
                                                                  decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                    // color: Colors.grey,
                                                                  ),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Column(
                                                                    children: const [
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
                                                        ),
                                                        Row(
                                                          children: [
                                                            ///////////
                                                            Flexible(
                                                              child: Container(
                                                                  decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.only(bottomLeft: Radius.circular(0)),
                                                                    // color: Colors.grey,
                                                                  ),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Column(
                                                                    children: const [
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
                                                                  child: const Padding(
                                                                    padding:
                                                                    EdgeInsets.only(left: 10),
                                                                    child:
                                                                    Text(
                                                                      "2567",
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
                                                    trailing: InkWell(
                                                        onTap: () {
                                                          //OrderDetailsPage().launch(context);
                                                        },
                                                        child: Text(
                                                            _selectedValueIndex ==
                                                                    0
                                                                ? "Draft"
                                                                : _selectedValueIndex ==
                                                                        1
                                                                    ? "In Process"
                                                                    : "Approved",
                                                            style: TextStyle(
                                                                color: _selectedValueIndex ==
                                                                        0
                                                                    ? Colors.red
                                                                    : _selectedValueIndex ==
                                                                            1
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .green,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => addNewOrderForPo(),));

        },
        elevation: 10,
        child: const Icon(Icons.add),
      ),
    );
  }
}
