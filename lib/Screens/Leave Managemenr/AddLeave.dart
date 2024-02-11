// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Expense%20Management/expense_list.dart';
import 'package:maan_hrm/constant.dart';
import 'package:multiselect/multiselect.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddLeave extends StatefulWidget {
   AddLeave({Key? key}) : super(key: key);

  @override
  _AddLeaveState createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  String employee = 'Sahidul Islam';
  String purpose = 'Privilege Leave (PL)';
  bool selection = false;
  List<String> selected = [];

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  bool isVisible = false;bool isVisible1 = true;

  var DayType="Full Day";

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
    _selectTime(context).dispose();
  }

  DropdownButton<String> getEmployee() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in employeeName) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }

    return DropdownButton(
      items: dropDownItems,
      value: employee,
      onChanged: (value) {
        setState(() {
          employee = value!;
        });
      },
    );
  }

  DropdownButton<String> getLeaveType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in expensePurpose) {
      var item = DropdownMenuItem(
        value: gender,
        child: Text(gender,overflow: TextOverflow.visible),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: purpose,
      onChanged: (value) {
        setState(() {
          purpose = value!;
        });
      },
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    setState(() {
      selectedTime = timeOfDay!;
      timeController.text = "${selectedTime.hour}:${selectedTime.minute}";
      //timeController.text=selectedTime.toString();
      log("${selectedTime.minute}:${selectedTime.hour}");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Add Leave',
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 20.0,
            ),
            Container(
              height: context.height(),
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Leave Type',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(
                              child: getLeaveType()),
                        );
                      },
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                DayType != "Full Day"
                                    ? Colors.orange
                                    : Colors.red),
                            onPressed: () {
                              setState(() {});
                              DayType = "Full Day";
                              if(DayType=="Full Day"){
                                isVisible=false;
                                isVisible1=true;
                              }
                              else{
                                isVisible=true;
                                isVisible1=false;
                              }
                            },
                            icon: Icon(Icons.calendar_month),
                            label:  Text(
                              "Full Day",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                DayType != "Half Day"
                                    ? Colors.orange
                                    : Colors.red),
                            onPressed: () {
                              setState(() {});
                              DayType = "Half Day";
                              if(DayType=="Full Day"){
                                isVisible=false;
                                isVisible1=true;
                              }
                              else{
                                isVisible=true;
                                isVisible1=false;
                              }
                              //shortleavetype = "Personal";
                              /*Navigator.push(context, MaterialPageRoute(builder: (context) => barCodeForShortLeaves(
                                          shortleavetype:"Personal",
                                          ReturnType:"RETURN"
                                      ),));*/
                            },
                            icon: Icon(Icons.calendar_month),
                            label:  Text(
                              "Half Day",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ToggleSwitch(
                  //   minWidth: 200.0,
                  //   initialLabelIndex: 0,
                  //   cornerRadius: 20.0,
                  //   activeFgColor: Colors.white,
                  //   inactiveBgColor: Colors.grey,
                  //   inactiveFgColor: Colors.white,
                  //   //animate: true,
                  //   // animationDuration: 4,
                  //   totalSwitches: 2,
                  //   labels:  ['Full Day', 'Half Day'],
                  //   icons:  [Icons.calendar_month, Icons.calendar_month],
                  //   activeBgColors:  [
                  //     [Colors.orange],
                  //     [Colors.orange]
                  //   ],
                  //   onToggle: (index) {
                  //     print('switched to: $index');
                  //     setState(() {
                  //
                  //     });
                  //       if(index==0){
                  //         isVisible=false;
                  //       }
                  //       else{
                  //         isVisible=true;
                  //       }
                  //
                  //   },
                  // ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: isVisible1,
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
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.date_range_rounded,
                                  color: kGreyTextColor,
                                ),
                                labelText: 'To Date',
                                hintText: '11/09/2021'),
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
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.date_range_rounded,
                                  color: kGreyTextColor,
                                ),
                                labelText: 'From Date',
                                hintText: '11/09/2021'),
                          ),
                        ),
                      ],
                    ),
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
                              var date = await _selectTime(context);
                              timeController.text =
                                  date.toString().substring(0, 10);
                            },
                            controller: timeController,
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.date_range_rounded,
                                  color: kGreyTextColor,
                                ),
                                labelText: 'To Time',
                                hintText: '10:00 AM'),
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
                              await _selectTime(context);
                              timeController.text;
                            },
                            controller: timeController,
                            decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Icon(
                                  Icons.date_range_rounded,
                                  color: kGreyTextColor,
                                ),
                                labelText: 'From Time',
                                hintText: '5:14 PM'),
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration:  InputDecoration(
                      labelText: 'Description',
                      // hintText: '543223',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Save',
                    buttonDecoration:
                        kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                       ExpenseList().launch(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
