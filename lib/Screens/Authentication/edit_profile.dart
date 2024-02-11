// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class EditProfile extends StatefulWidget {
   EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String gender = 'Male';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Edit Profile',
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
                   Image(
                    image: AssetImage(
                      'images/employeeaddimage.png',
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'MaanTheme',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Owner/Admin name',
                      hintText: 'MaanTeam',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    decoration:  InputDecoration(
                      labelText: 'Email Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'maantheme@maantheme.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '+8801767 432556',
                      labelStyle: kTextStyle,
                      border:  OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    // ignore: deprecated_member_use
                    textFieldType: TextFieldType.ADDRESS,
                    decoration:  InputDecoration(
                      labelText: 'Company Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: '112/3 Green Road',
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
                  ButtonGlobal(
                    buttontext: 'Update',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: null,
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
