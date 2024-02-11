// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Employee%20management/add_employee.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendance_details.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/mark_attendance.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class AttendanceEmployeeList extends StatefulWidget {
   AttendanceEmployeeList({Key? key}) : super(key: key);

  @override
  _AttendanceEmployeeListState createState() => _AttendanceEmployeeListState();
}

class _AttendanceEmployeeListState extends State<AttendanceEmployeeList> {
  List<String> data = ["Sahidul Islam", "Mehedi Mohammad", "Ibne Riead", "Emily Jones"];
  List<String> designation = ["Designer", "Manager", "Developer", "Officer"];
  List<String> pic = ["images/emp1.png", "images/emp2.png", "images/emp3.png", "images/emp4.png"];
  List<String> userChecked = [];

  final dateController = TextEditingController();
  bool mark = false;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           AddEmployee().launch(context);
        },
        backgroundColor: kMainColor,
        child:  Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Employee List',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions:  [
          Image(
            image: AssetImage('images/employeesearch.png'),
          ),
        ],
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
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                            dateController.text = date.toString().substring(0, 10);
                          },
                          controller: dateController,
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Icon(
                                Icons.date_range_rounded,
                                color: kGreyTextColor,
                              ),
                              labelText: 'Date',
                              hintText: '11/09/2021'),
                        ),
                      ),
                       SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            userChecked.isEmpty
                                ? setState(() {
                                    mark = !mark;
                                  })
                                :  MarkAttendance().launch(context);
                          },
                          child: Container(
                            height: 60.0,
                            padding:  EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: kMainColor),
                              color: userChecked.isEmpty ? Colors.white : kTitleColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  color: userChecked.isEmpty ? kTitleColor : Colors.white,
                                ),
                                 SizedBox(
                                  width: 2.0,
                                ),
                                Text(
                                  userChecked.isEmpty ? 'Mark Attendance' : 'Continue',
                                  style: kTextStyle.copyWith(color: userChecked.isEmpty ? kTitleColor : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: !mark,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                      Padding(
                      padding:  EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                        ),
                        child: ListTile(
                          onTap: () {
                             AttendanceDetails().launch(context);
                          },
                          leading: Image.asset('images/attendance.png'),
                          title: Text(
                            "Start MyDay",
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            "",
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          trailing:  Icon(
                            Icons.arrow_forward_ios,
                            color: kGreyTextColor,
                          ),
                        ),
                      ),
                    )
                        ],
                      )
                      ),
                    ),
                  Visibility(
                    visible: mark,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding:  EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                              ),
                              child: CheckboxListTile(
                                shape:  CircleBorder(),
                                value: userChecked.contains(data[i]),
                                onChanged: (val) {
                                  _onSelected(val!, data[i]);
                                },
                                secondary: Image.asset(pic[i]),
                                title: Text(
                                  data[i],
                                  style: kTextStyle,
                                ),
                                subtitle: Text(
                                  designation[i],
                                  style: kTextStyle.copyWith(color: kGreyTextColor),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
