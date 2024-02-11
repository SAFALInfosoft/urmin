// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Authentication/sign_in.dart';
import 'package:maan_hrm/Screens/Home/SFA_DashBoard.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class SignUp extends StatefulWidget {
   SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String employee = '0 - 10';

  DropdownButton<String> getEmployee() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String emp in employees) {
      var item = DropdownMenuItem(
        value: emp,
        child: Text(emp),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Sign In',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(20.0),
              child: Text(
                'Sign Up now to begin an amazing journey',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
            ),
            Container(
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
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'MaanTheme',
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
                      hintText: 'maantheme@maantheme.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: TextEditingController(),
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '1767 432556',
                        labelStyle: kTextStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border:  OutlineInputBorder(),
                        // prefixIcon: CountryCodePicker(
                        //   padding: EdgeInsets.zero,
                        //   onChanged: print,
                        //   initialSelection: 'BD',
                        //   showFlag: true,
                        //   showDropDownButton: true,
                        //   alignLeft: false,
                        // ),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: kTextStyle,
                      hintText: 'Enter password',
                      border:  OutlineInputBorder(),
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
                          child: DropdownButtonHideUnderline(child: getEmployee()),
                        );
                      },
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Sign Up',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                       HomeScreen().launch(context);
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have an account? ',
                          style: kTextStyle.copyWith(
                            color: kGreyTextColor,
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            'Sign In',
                            style: kTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kMainColor,
                            ),
                          ).onTap(() {
                             SignIn().launch(context);
                          }),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Or Sign Up With...',
                    style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                  ),
                  Hero(
                    tag: 'social',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 2.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.facebookF,
                                color: Color(0xFF3B5998),
                              )),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                            child: Center(
                              child: Image.asset(
                                'images/google.png',
                                height: 25.0,
                                width: 25.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 2.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Color(0xFF3FBCFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
