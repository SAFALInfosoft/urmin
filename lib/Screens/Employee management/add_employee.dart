// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../PartyList/MyPartyListPage.dart';
import '../../constant.dart';

class AddEmployee extends StatefulWidget {
   AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  List<String> data = ["Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"];
  List<String> userChecked = [];
  String designation = 'Designer';
  String gender = 'Male';
  bool selection = false;
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  DropdownButton<String> getDesignation() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in designations) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: designation,
      onChanged: (value) {
        setState(() {
          designation = value!;
        });
      },
    );
  }

  DropdownButton<String> getGender() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in genderList) {
      var item = DropdownMenuItem(
        value: gender,
        child: Text(gender),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: gender,
      onChanged: (value) {
        setState(() {
          gender = value!;
        });
      },
    );
  }

  // void _onSelected(bool selected, String dataName) {
  //   if (selected == true) {
  //     setState(() {
  //       userChecked.add(dataName);
  //     });
  //   } else {
  //     setState(() {
  //       userChecked.remove(dataName);
  //     });
  //   }
  // }

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
          'Attendance',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              //height: MediaQuery.of(context).size.height,
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      decoration:  BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFFFD73B0),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset('images/Pro.png',height: 100,width: 100,),
                          ),
                          Expanded(
                            flex: 2,
                            child: Material(
                              elevation: 0.0,
                              child: Container(
                                width: context.width(),
                                padding:  EdgeInsets.all(10.0),
                                decoration:  BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                         AddEmployee().launch(context);
                                      },
                                      child: Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                               AddEmployee().launch(context);
                                            },
                                            //leading: Image.asset('images/attendance.png',height: 40,width: 40,),
                                            title: Text(
                                              "Start MyDay",
                                              style: kTextStyle,
                                            ),
                                            subtitle: Text(
                                              "1:16 PM 26/10/2023",
                                              style: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                            trailing:  Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                     SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () {
                                         AddEmployee().launch(context);
                                      },
                                      child: Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                               AddEmployee().launch(context);
                                            },
                                            //leading: Image.asset('images/attendance.png',height: 40,width: 40,),
                                            title: Text(
                                              "End MyDay",
                                              style: kTextStyle,
                                            ),
                                            subtitle: Text(
                                              "Pending...",
                                              style: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                            trailing:  Icon(
                                              Icons.access_time_sharp,
                                              color: kGreyTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      //padding:  EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 15.0),
                      decoration: BoxDecoration(
                        border:  Border(
                            left: BorderSide(
                              color: Color(0xFF4CE364),
                            )),
                        color:  Color(0xFF4CE364).withOpacity(0.1),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Today`s Route',
                              style: kTextStyle.copyWith(color:  Color(0xFF4CE364), fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Bopal-Ambli Road,Ahmedabad',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /*AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'MaanTheme',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration:  InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: '+880 1767 543223',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Select Designation',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(child: getDesignation()),
                        );
                      },
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: !selection,
                    child: SizedBox(
                      height: 60.0,
                      child: FormField(
                        builder: (FormFieldState<dynamic> field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: 'Working Day',
                                labelStyle: kTextStyle,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selection = true;
                                });
                              },
                              child: Text(userChecked.isEmpty ? 'Select Working Day' : userChecked.join(",")),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selection,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics:  NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding:  EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CheckboxListTile(
                                  title: Text(data[i]),
                                  value: userChecked.contains(data[i]),
                                  onChanged: (val) {
                                    _onSelected(val!, data[i]);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        ButtonGlobal(
                            buttontext: 'Add Days',
                            buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                            onPressed: () {
                              setState(() {
                                selection = false;
                              });
                            })
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppTextField(
                          textFieldType: TextFieldType.PHONE,
                          decoration:  InputDecoration(
                            labelText: 'Basic Pay',
                            hintText: '\$00.00',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                       SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Container(
                              padding:  EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: kMainColor,
                              ),
                              child: Text(
                                'Per Day',
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                            ),
                             SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              padding:  EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: kMainColor),
                              ),
                              child: Text(
                                'Monthly',
                                style: kTextStyle.copyWith(color: kMainColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Select Gender',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(child: getGender()),
                        );
                      },
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Add Reference',
                      hintText: 'Enter Reference Name',
                      suffixIcon: Icon(
                        Icons.add,
                        color: kGreyTextColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Sign Up',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                       EmployeeAddSuccessful().launch(context);
                    },
                  ),*/
                ],
              ),
            ),
          ),

          Container(
            color: Colors.white,
            padding:  EdgeInsets.only(
                left: 30.0, right: 30.0, top: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPartyList(),));
                  //onNextPageChangeTapped();
                });
              },
              child: Container(
                //width: 100.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: kMainColor,
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child:  Center(
                  child: Text(
                    'End MyDay',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins_regular',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
