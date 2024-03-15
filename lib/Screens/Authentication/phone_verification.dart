// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/GlobalComponents/otp_form.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../GlobalComponents/PreferenceManager.dart';
import '../../RESPONSE/otpVerificationResponse.dart';
import '../../RSM_Screens/RSM_DashBoard.dart';
import '../../constant.dart';
import '../../DMS_Screens/DMS_DashBoard.dart';
import '../Home/SFA_DashBoard.dart';

class PhoneVerification extends StatefulWidget {
   PhoneVerification({Key? key}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String? mobile;
  String? clientUrl;

  String? company;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    PreferenceManager.instance
        .getStringValue("Mobile")
        .then((value) => setState(() {
              mobile = value;
              print(value);
            }));
    PreferenceManager.instance
        .getStringValue("ClintUrl")
        .then((value) => setState(() {
              clientUrl = value;
              print(value);
            }));
    PreferenceManager.instance
        .getStringValue("companyCode")
        .then((value) => setState(() {
              company = value;
              print(value);
              //clientUrl="https://demo.datanote.co.in/urminapi/";
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
        leading: Container(),
        centerTitle: true,
        // iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Enter Otp',
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/logo.png"),
              minRadius: 50,
              maxRadius: 50,
            ),
          ),
          Expanded(
            child: Container(
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
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border:  Border(
                          left: BorderSide(
                        color: kAlertColor,
                        width: 3.0,
                      )),
                      color: kAlertColor.withOpacity(0.1),
                    ),
                    child: Text(
                      'OTP Input',
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                   OtpForm(),
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding:  EdgeInsets.all(10.0),
                    decoration: kButtonDecoration.copyWith(
                        color: kTitleColor.withOpacity(0.1)),
                    child: Text(
                      'Resend Otp',
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'You can request otp again after ',
                          style: kTextStyle.copyWith(
                            color: kAlertColor,
                          ),
                        ),
                        TextSpan(
                          text: '1:12',
                          style: kTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kAlertColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Verify Otp',
                    buttonDecoration: kButtonDecoration.copyWith(
                        color: kMainColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: () {
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  Dms_HomeScreen()));
                      _submit();
                      //  PhoneVerification().launch(context);
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

  Future<void> submit() async {
    //clientUrl="https://demo.datanote.co.in/urminapi/";
    /*   isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId").toString();
    token = Uri.encodeComponent(prefs.getString("token").toString());
    co_code = prefs.getString("co_code").toString();*/
    isLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      "Mobile_No": mobile,
      "Company_Id": company,
      "MoB_OTP": "1111"
    };

    print("${clientUrl}LogIn/MOB_Update_company_id_login$payload");
    var res = await dio.post("${clientUrl}LogIn/MOB_Update_company_id_login",
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
      /* isLoading = false; */
      var json = jsonDecode(res.data);
      log("OtpRES" + json['message'].toString());
      Dms_HomeScreen().launch(context);
    } else {
      // show error
      print("Try Again");
    }
  }

  Future<void> _submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  device_token = (await _firebaseMessaging.getToken())!;

    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Map data = {"Mobile_No": mobile, "Company_Id": company, "MoB_OTP": "1111"};
    log('OTPVerificationScreen :=> "${clientUrl}LogIn/MOB_Update_company_id_login" Api Body ==> $data');
    final response = await http.post(
      Uri.parse("${clientUrl}LogIn/MOB_Update_company_id_login"),
      body: data,
    );
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
    var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      log(response.body.toString());
      var map = Map<String, dynamic>.from(jsonData);
      log(map.toString());
      var response1 = OtpVerificationResponse.fromJson(map);
      if (response1.settings.success == "1") {
        PreferenceManager.instance.setBooleanValue("Login", true);
        PreferenceManager.instance
            .setStringValue("accessToken", response1.message[0].moAccessToken);
        PreferenceManager.instance.setStringValue(
            "distributorId", response1.message[0].distributorId);
        PreferenceManager.instance.setStringValue(
            "distributorName", response1.message[0].distributorName);
        PreferenceManager.instance.setStringValue(
            "companyGst", response1.message[0].companyGst);
        PreferenceManager.instance.setStringValue(
            "companyStateCode", response1.message[0].companyStateCode);
        PreferenceManager.instance
            .setStringValue("companyId", response1.message[0].companyId);
        PreferenceManager.instance
            .setStringValue("companyName", response1.message[0].companyName);
        PreferenceManager.instance
            .setStringValue("factoryId", response1.message[0].factoryId);
        PreferenceManager.instance
            .setStringValue("factoryName", response1.message[0].factoryName);
        PreferenceManager.instance
            .setStringValue("businessName", response1.message[0].businessName);
        PreferenceManager.instance
            .setStringValue("role", response1.message[0].role);
        if (response1.message[0].distributorId == "RSM2") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => RSM_HomeScreen()
          ));
        } else {
          ErpMainDataFetch(response1.message[0].distributorId).then((value) =>
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Dms_HomeScreen()
              ))
          );
        }

      } else {
        Fluttertoast.showToast(
            msg: "Something Wrong!",
            textColor: Colors.white,
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something Wrong!",
          textColor: Colors.white,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

 Future <void> ErpMainDataFetch(distributorId) async {
    // Replace with your actual API URL

    String apiUrl = 'https://api.urmingroup.co.in/fcustomer/_find';

    // Replace with your actual authorization key
    String authorizationKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload

    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "$distributorId"}
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
          PhoneVerification().launch(context);
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
}
