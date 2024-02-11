import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendence_management.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

// ignore_for_file: library_private_types_in_public_api
class MarkAttendance extends StatefulWidget {
   MarkAttendance({Key? key}) : super(key: key);

  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  bool isPresent = false;
  bool isAbsent = false;
  bool isHalfDay = false;
  bool isHoliday = false;
  bool inTimeSelected = false;
  bool outTimeSelected = false;
  TimeOfDay selectedInTime = TimeOfDay.now();
  TimeOfDay selectedOutTime = TimeOfDay.now();

  _selectInTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedInTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedInTime) {
      setState(() {
        selectedInTime = timeOfDay;
        inTimeSelected = true;
      });
    }
  }

  _selectOutTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedOutTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedOutTime) {
      setState(() {
        selectedOutTime = timeOfDay;
        outTimeSelected = true;
      });
    }
  }

  @override
  void dispose() {
    _selectInTime(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Mark Attendance',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
              width: context.width(),
              height: context.height(),
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: kBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Attendance',
                          style: kTextStyle,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPresent = !isPresent;
                                });
                              },
                              child: Container(
                                padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: isPresent ? kMainColor : kMainColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Present',
                                  style: kTextStyle.copyWith(color: isPresent ? Colors.white : kMainColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                                ),
                              ),
                            ),
                             Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAbsent = !isAbsent;
                                });
                              },
                              child: Container(
                                padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: isAbsent ? kAlertColor : kAlertColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Absent',
                                  style: kTextStyle.copyWith(
                                    color: isAbsent ? Colors.white : kAlertColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHalfDay = !isHalfDay;
                                });
                              },
                              child: Container(
                                padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: isHalfDay ? kHalfDay : kHalfDay.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Half Day',
                                  style: kTextStyle.copyWith(color: isHalfDay ? Colors.white : kHalfDay, fontWeight: FontWeight.bold, fontSize: 18.0),
                                ),
                              ),
                            ),
                             Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHoliday = !isHoliday;
                                });
                              },
                              child: Container(
                                padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: isHoliday ? kGreenColor : kGreenColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Holiday',
                                  style: kTextStyle.copyWith(
                                    color: isHoliday ? Colors.white : kGreenColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Attendance',
                          style: kTextStyle,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: inTimeSelected,
                              child: Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: kGreyTextColor),
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              _selectInTime(context);
                                            },
                                            child: Text("${selectedInTime.hour}:${selectedInTime.minute} ${selectedInTime.period.toString().substring(10, 12)}")),
                                         Spacer(),
                                         Icon(
                                          Icons.access_time,
                                          color: kGreyTextColor,
                                        ),
                                         SizedBox(
                                          width: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !inTimeSelected,
                              child: Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.all(4.0),
                                  child: AppTextField(
                                    textFieldType: TextFieldType.NAME,
                                    readOnly: true,
                                    onTap: () async {
                                      _selectInTime(context);
                                    },
                                    decoration:  InputDecoration(
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        suffixIcon: Icon(
                                          Icons.access_time,
                                          color: kGreyTextColor,
                                        ),
                                        labelText: 'In Time',
                                        hintText: 'In Time'),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: outTimeSelected,
                              child: Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: kGreyTextColor),
                                    ),
                                    child: Row(
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              _selectOutTime(context);
                                            },
                                            child: Text("${selectedOutTime.hour}:${selectedOutTime.minute} ${selectedOutTime.period.toString().substring(10, 12)}")),
                                         Spacer(),
                                         Icon(
                                          Icons.access_time,
                                          color: kGreyTextColor,
                                        ),
                                         SizedBox(
                                          width: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !outTimeSelected,
                              child: Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.all(4.0),
                                  child: AppTextField(
                                    textFieldType: TextFieldType.NAME,
                                    readOnly: true,
                                    onTap: () async {
                                      _selectOutTime(context);
                                    },
                                    decoration:  InputDecoration(
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        suffixIcon: Icon(
                                          Icons.access_time,
                                          color: kGreyTextColor,
                                        ),
                                        labelText: 'Out Time',
                                        hintText: 'Out Time'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Pay',
                          style: kTextStyle,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: AppTextField(
                                textFieldType: TextFieldType.NAME,
                                decoration:  InputDecoration(
                                    border: OutlineInputBorder(), floatingLabelBehavior: FloatingLabelBehavior.always, labelText: 'Advance / Loan', hintText: '\$10.00'),
                              ),
                            ),
                             SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: AppTextField(
                                textFieldType: TextFieldType.NAME,
                                decoration:  InputDecoration(
                                    border: OutlineInputBorder(), floatingLabelBehavior: FloatingLabelBehavior.always, labelText: 'Bonus', hintText: '\$10.00'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 40.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Submit Attendance',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                       AttendanceManagement().launch(context);
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
