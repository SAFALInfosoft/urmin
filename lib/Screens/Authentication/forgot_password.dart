// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Authentication/phone_verification.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';

class ForgotPassword extends StatefulWidget {
   ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Forgot Password',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.all(20.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur.',
              style: kTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
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
                  ButtonGlobal(
                    buttontext: 'Get Otp',
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                       PhoneVerification().launch(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
