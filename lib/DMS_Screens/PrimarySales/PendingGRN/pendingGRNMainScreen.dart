// ignore_for_file: library_private_types_in_public_api

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Employee%20Overtime/empty_employee_overtime.dart';
import 'package:maan_hrm/Screens/Employee%20management/empty_employee.dart';
import 'package:maan_hrm/Screens/Leave%20Managemenr/leave_management.dart';
import 'package:maan_hrm/Screens/Reference%20Management/empty_reference.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/empty_salary_statement.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendance_employee_list.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:intl/intl.dart';

import '../../../constant.dart';

class pendingGRNMainScreen extends StatefulWidget {
   pendingGRNMainScreen({Key? key}) : super(key: key);

  @override
  _pendingGRNMainScreenState createState() =>
      _pendingGRNMainScreenState();
}

class _pendingGRNMainScreenState extends State<pendingGRNMainScreen> {
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
                  ?  Color(0xFF4CCEFA)
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

  List<String> buttonText = ["Pending GRN", "Completed GRN"];
  int _selectedValueIndex = 0;
  PopupMenuItem _buildPopupMenuItem(
     IconData, String title) {
    return PopupMenuItem(
      child:  InkWell(
        onTap: () {

          setState(() {

          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(

                // title: TextStyleExample(name : 'Privacy',style : textTheme.titleMedium!.copyWith(color: MyColors.black, fontWeight: FontWeight.bold)),
                title:  Center(child: Text("Transporter Details")),
                content: Expanded(
                  child: Column(
                    children:  [
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('TRANSPORTER NAME'),
                        subtitle: Text('Shiv shakti shipping'),
                       // trailing: Icon(Icons.arrow_forward),
                      ), ListTile(
                        leading: Icon(Icons.call),
                        title: Text('TRANSPORTER NUMBER'),
                        subtitle: Text('+91 8839319201'),
                       // trailing: Icon(Icons.arrow_forward),
                      ),ListTile(
                        leading: Icon(Icons.fire_truck),
                        title: Text('VEHICLE TYPE'),
                        subtitle: Text('Mini-Van'),
                        // trailing: Icon(Icons.arrow_forward),
                      ), ListTile(
                        leading: Icon(Icons.numbers),
                        title: Text('VEHICLE NO'),
                        subtitle: Text('GJ-01-FC-7623'),
                       // trailing: Icon(Icons.arrow_forward),
                      ),ListTile(
                        leading: Icon(Icons.person),
                        title: Text('DRIVER NAME'),
                        subtitle: Text('Mr.shaktisinh zala'),
                      //  trailing: Icon(Icons.arrow_forward),
                      ),ListTile(
                        leading: Icon(Icons.call),
                        title: Text('DRIVER NUMBER'),
                        subtitle: Text('+91 6353100000'),
                       // trailing: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child:  Text("Cancel"),
                    //child: TextStyleExample(name : 'DISAGREE',style : textTheme.labelLarge!),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              );
            },
          );
        },
        child: Row(
          children: [
            Icon(IconData,color: Colors.blue),
             SizedBox(width: 5,),
            Text(title),
          ],
        ),
      ),
    );
  }
  void confirmationDialog(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(

          // title: TextStyleExample(name : 'Privacy',style : textTheme.titleMedium!.copyWith(color: MyColors.black, fontWeight: FontWeight.bold)),
          title:  Text("Exit!"),
          content:  Text("Are you sure want to exit?",
              style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child:  Text("Cancel"),
              //child: TextStyleExample(name : 'DISAGREE',style : textTheme.labelLarge!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // child: TextStyleExample(name : 'AGREE',style : textTheme.labelLarge!.copyWith(color: MyColors.accentDark)),
              child:  Text("Sure"),
              onPressed: () {

              },
            )
          ],
        );
      },
    );
  }
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
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'GRN',
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
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
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
                        padding:  EdgeInsets.only(left: 0, right: 10),
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
                               BorderRadius.all(Radius.circular(12)),
                              border:
                              Border.all(color: Colors.black, width: 1.1),
                              color: Colors.white,
                            ),
                            child:  Padding(
                                padding: EdgeInsets.all(5.0),
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
                    padding:  EdgeInsets.all(8.0),
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
                                border:  OutlineInputBorder(),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                suffixIcon:  Icon(
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
                                border:  OutlineInputBorder(),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                suffixIcon:  Icon(
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
                                          child: Padding(
                                            padding:  EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Material(
                                                elevation: 2.0,
                                                child: Container(
                                                  width: context.width(),
                                                  padding:  EdgeInsets.all(
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
                                                        Column(
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
                                                                              "Purchase No",
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
                                                                          "PO/GEN/23-24/23",
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
                                                                              "Invoice No",
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
                                                                          "INV/GEN/23-24/23",
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
                                                                              "Shipping Address",
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
                                                                          "Sarkhej factory",
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
                                                    trailing: PopupMenuButton(
                                                      itemBuilder: (ctx) => [
                                                        _buildPopupMenuItem(Icons.fire_truck,'Transporter Details'),
                                                        _buildPopupMenuItem(Icons.file_copy_outlined,'E-way bill Detail'),
                                                        _buildPopupMenuItem(Icons.file_copy_outlined,'Delivery Challan'),
                                                        _buildPopupMenuItem(Icons.file_copy_outlined,'Packing Slip'),
                                                        _buildPopupMenuItem(Icons.file_copy_outlined,'Delivery Receipt'),
                                                        _buildPopupMenuItem(Icons.print,'Print Invoice'),
                                                      ],
                                                    ),
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
        },
        elevation: 10,
        child:  Icon(Icons.add),
      ),
    );
  }
}
