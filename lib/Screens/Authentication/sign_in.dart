// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Authentication/forgot_password.dart';
import 'package:maan_hrm/Screens/Authentication/phone_verification.dart';
import 'package:maan_hrm/Screens/Authentication/sign_up.dart';
import 'package:maan_hrm/Screens/Home/SFA_DashBoard.dart';
import 'package:maan_hrm/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/PreferenceManager.dart';
import 'package:http/http.dart' as http;

import '../../RESPONSE/erpApiMainDataResponse.dart';
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

  bool isLoading = false;

  var clientUrl;

  var selectionItems;

  TextEditingController compneyNameController = TextEditingController();

  var reportSelected;

  var selectedCode;

  void ErpMainDataFetch() async {
    // Replace with your actual API URL
    String apiUrl = 'http://111.93.85.179:5984/fcustomer/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "50c60cdef1e5286ef69f0256ab03c577"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Parse and handle the response JSON
        Map<String, dynamic> responseBody = json.decode(response.body);
        //ErpApiMainDataResponse =responseBody;
        // Do something with the response data
        print(responseBody);
      } else {
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
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

      clientUrl="https://demo.datanote.co.in/urminapi/";
    }));
setState(() {

});
    ErpMainDataFetch();
    CallApiForCompneyName();
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
                  Visibility(
                    visible:selectionItems==""?false:true,
                    child: SizedBox(
                      height: 60.0,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  label: Text("Select Company"),

                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                              style: const TextStyle(fontSize: 15, color: Colors.black),
                              controller: compneyNameController,
                              // decoration: InputDecoration(
                            ),
                          ),
                          PopupMenuButton(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (value) {
                              setState(() {
                                var selectedItem = selectionItems.firstWhere(
                                      (item) => item["Select_Value"] == value,
                                );
                                compneyNameController.text = value.toString();
                                selectedCode = selectedItem["Select_Value_Code"];
                                log(selectedCode);

                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return selectionItems.map<PopupMenuItem>((value) {
                                return PopupMenuItem(
                                    height: 50,
                                    value: value["Select_Value"],
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child:
                                          Text(value["Select_Value"], style: const TextStyle(fontSize: 12)),
                                        ),
                                      ],
                                    ));
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*SizedBox(
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
                  ),*/
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible:selectionItems==""?false:true,
                    child: ButtonGlobal(
                      buttontext: 'Get Otp',
                      buttonDecoration: kButtonDecoration.copyWith(color: kMainColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                      onPressed: () {
                        PhoneVerification().launch(context);
                      //  const HomeScreen().launch(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> CallApiForCompneyName() async {
    clientUrl="https://demo.datanote.co.in/urminapi/";
    /*   isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId").toString();
    token = Uri.encodeComponent(prefs.getString("token").toString());
    co_code = prefs.getString("co_code").toString();*/
    isLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      "Mobile_No":"+916353100160",
    };

    print(clientUrl+"LogIn/MOB_Login_Company_List$payload");
    var res = await dio.get("${clientUrl}LogIn/MOB_Login_Company_List",
        //data: formData,
        queryParameters: payload,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    print('---- status code: ${res.statusCode}');

    if (res.statusCode == 200) {
      /*     isLoading = false;*/
      var json = jsonDecode(res.data);
      selectionItems = json['message'];
    } else {
      // show error
      print("Try Again");
    }
  }
}
