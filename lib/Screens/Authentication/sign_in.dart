// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
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
  SignIn({Key? key}) : super(key: key);

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

  List selectionItems = [];

  TextEditingController compneyNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  var reportSelected;

  var selectedCode;

  void ErpMainDataFetch() async {
    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fcustomer/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "dcbd62d4d5e6446634e5ba708be6e850"}
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
        debugPrint("responseBody $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody ${body}");
        var box = Hive.box('erpApiMainData');
        box.put('erpApiMainData', body);
        await Hive.openBox('erpApiMainData');
        Map<String, dynamic> bookmark = box.get('erpApiMainData');
        bookmark.forEach((key, value) {
          if (key == 'bookmark') {
            debugPrint("bookmark $value");
          }
        });
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
              RoleType = value;
              print(value);

              //  clientUrl="https://demo.datanote.co.in/urminapi/";
            }));
    PreferenceManager.instance
        .getStringValue("ClintUrl")
        .then((value) => setState(() {
              clientUrl = value;
              print(value);
              //clientUrl="https://demo.datanote.co.in/urminapi/";
            }));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    codeController.text = "+91";
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        // iconTheme:  IconThemeData(color: Colors.white),
        // centerTitle: true,
        leading: Container(),
        centerTitle: true,
        title: Text(
          '$RoleType Sign In',
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
              minRadius: 50,
              maxRadius: 50,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 70,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: codeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              // You can add more custom validation logic here if needed
                              return null;
                            },
                            maxLength: 4,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '11111 11111',
                              labelStyle: kTextStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              counter: SizedBox.shrink(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
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
                          width: 10.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: mobileController,
                              maxLength: 10,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 10) {
                                  return 'Please Check mobile number';
                                } else if (value.length == 10) {
                                  return null;
                                }
                                // You can add more custom validation logic here if needed
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                              enabled: true,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '11111 11111',
                                counter: SizedBox.shrink(),
                                labelStyle: kTextStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),

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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Visibility(
                      visible: false,
                      child: SizedBox(
                        height: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    label: Text("Select Company"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: compneyNameController,
                                // decoration: InputDecoration(
                              ),
                            ),
                            PopupMenuButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onSelected: (value) {
                                setState(() {
                                  var selectedItem = selectionItems.firstWhere(
                                    (item) => item["Select_Value"] == value,
                                  );
                                  compneyNameController.text = value.toString();
                                  selectedCode =
                                      selectedItem["Select_Value_Code"];
                                  log(selectedCode);
                                  PreferenceManager.instance.setStringValue(
                                      "companyName", value.toString());
                                  PreferenceManager.instance.setStringValue(
                                      "companyCode", selectedCode.toString());
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return selectionItems
                                    .map<PopupMenuItem>((value) {
                                  return PopupMenuItem(
                                      height: 50,
                                      value: value["Select_Value"],
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(value["Select_Value"],
                                                style: TextStyle(fontSize: 12)),
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
                    //  SizedBox(
                    //   height: 20.0,
                    // ),
                    Visibility(
                      visible: selectionItems == "" ? false : true,
                      child: ButtonGlobal(
                        buttontext: 'Process',
                        buttonDecoration: kButtonDecoration.copyWith(
                            color: kMainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            var mob =
                                "${codeController.text}${mobileController.text}";
                            log(mob.toString());
                            PreferenceManager.instance
                                .setStringValue("Mobile", mob.toString());
                            setState(() {
                              CallApiForCompneyName(mob);
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please Fill Data",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          //   HomeScreen().launch(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> CallApiForCompneyName(mob) async {
    //clientUrl="https://demo.datanote.co.in/urminapi/";
    /*   isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId").toString();
    token = Uri.encodeComponent(prefs.getString("token").toString());
    co_code = prefs.getString("co_code").toString();*/
    isLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      "Mobile_No": mob,
    };

    print(clientUrl + "LogIn/MOB_Login_Company_List$payload");
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
      log(json['settings']['success'].toString());

      selectionItems = json['message'];
      log(json);
      if (json['settings']['success'].toString() == "1") {
        if (selectionItems.length == 1) {
          log(selectionItems[0]['Select_Value_Code']);
          compneyNameController.text = selectionItems[0]['Select_Value'];
          selectedCode = selectionItems[0]['Select_Value_Code'];
          PreferenceManager.instance.setStringValue(
              "companyName", selectionItems[0]['Select_Value']);
          PreferenceManager.instance.setStringValue(
              "companyCode", selectedCode.toString());
        }
        debugPrint(selectionItems.length.toString());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Company'),
              content: SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            label: Text("Select Company"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        controller: compneyNameController,
                        // decoration: InputDecoration(
                      ),
                    ),
                    selectionItems.length > 1
                        ? PopupMenuButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onSelected: (value) {
                              setState(() {
                                var selectedItem = selectionItems.firstWhere(
                                  (item) => item["Select_Value"] == value,
                                );
                                compneyNameController.text = value.toString();
                                selectedCode = selectedItem["Select_Value_Code"];
                                log(selectedCode);
                                PreferenceManager.instance.setStringValue(
                                    "companyName", value.toString());
                                PreferenceManager.instance.setStringValue(
                                    "companyCode", selectedCode.toString());
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
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(value["Select_Value"],
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ],
                                    ));
                              }).toList();
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
              actions: [
                ButtonGlobal(
                  buttontext: 'Get Otp',
                  buttonDecoration: kButtonDecoration.copyWith(
                      color: kMainColor,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onPressed: () {
                    compneyNameController.text == ""
                        ? Fluttertoast.showToast(
                            msg: "Please Select Company",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0)
                        : PhoneVerification().launch(context);
                    //   HomeScreen().launch(context);
                  },
                )
              ],
            );
          },
        );
      } else {
        Fluttertoast.showToast(
            msg: "Please Check Mobile!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      // show error
      print("Try Again");
    }
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
