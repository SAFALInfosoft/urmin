// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Authentication/forgot_password.dart';
import 'package:maan_hrm/Screens/Authentication/phone_verification.dart';
import 'package:maan_hrm/Screens/Authentication/sign_up.dart';
import 'package:maan_hrm/Screens/Home/SFA_DashBoard.dart';
import 'package:maan_hrm/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/PreferenceManager.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final TextEditingController controller = TextEditingController();
  bool isChecked = false;
  String employee = 'Urmin';
  String Languages = 'English';

  String? RoleType;

  DropdownButton<String> getCompany() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String emp in Compney) {
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
  DropdownButton<String> getLanguage() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String emp in Language) {
      var item = DropdownMenuItem(
        value: emp,
        child: Text(emp),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: Languages,
      onChanged: (value) {
        setState(() {
          Languages = value!;
        });
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    PreferenceManager.instance
        .getStringValue("Role_Type")
        .then((value) => setState(() {
          RoleType=value;
      print(value);
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
       // iconTheme: const IconThemeData(color: Colors.white),
       // centerTitle: true,
        leading: Container(),
        centerTitle: true,
        title: Text(
          '$RoleType Sign In',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(
          //   color: Colors.white,
          //   thickness: 1
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
              minRadius: 50,
              maxRadius: 50,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
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
                        hintText: '+91 11111 11111',
                        labelStyle: kTextStyle,

                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: const OutlineInputBorder(),
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Select Company',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(child: getCompany()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Select Language',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(child: getLanguage()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Row(
                  //   children: [
                  //     Transform.scale(
                  //       scale: 0.8,
                  //       child: CupertinoSwitch(
                  //         value: isChecked,
                  //         thumbColor: kGreyTextColor,
                  //         onChanged: (bool value) {
                  //           setState(() {
                  //             isChecked = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     Text(
                  //       'Save Me',
                  //       style: kTextStyle,
                  //     ),
                  //     const Spacer(),
                  //     Text(
                  //       'Forgot Password?',
                  //       style: kTextStyle,
                  //     ).onTap(() {
                  //       const ForgotPassword().launch(context);
                  //     }),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  ButtonGlobal(
                    buttontext: 'Get Otp',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: () {
                      PhoneVerification().launch(context);
                    //  const HomeScreen().launch(context);
                    },
                  ),
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Don\'t have an account? ',
                  //         style: kTextStyle.copyWith(
                  //           color: kGreyTextColor,
                  //         ),
                  //       ),
                  //       WidgetSpan(
                  //         child: Text(
                  //           'Sign Up',
                  //           style: kTextStyle.copyWith(
                  //             fontWeight: FontWeight.bold,
                  //             color: kMainColor,
                  //           ),
                  //         ).onTap(() {
                  //           const SignUp().launch(context);
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
