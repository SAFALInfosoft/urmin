import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:maan_hrm/RouteManagement/RouteManagementMenuScreen.dart';
import 'package:maan_hrm/Screens/Authentication/profile_screen.dart';
import 'package:maan_hrm/Screens/Client%20Management/empty_client_list.dart';
import 'package:maan_hrm/Screens/Employee%20management/management_screen.dart';
import 'package:maan_hrm/Screens/Expense%20Management/management_screen.dart';
import 'package:maan_hrm/Screens/File%20Management/empty_file_management.dart';
import 'package:maan_hrm/Screens/Holiday%20Management/empty_holiday.dart';
import 'package:maan_hrm/Screens/Home/pricing_screen.dart';
import 'package:maan_hrm/Screens/Home/privacy_policy.dart';
import 'package:maan_hrm/Screens/Home/terms_of_service.dart';
import 'package:maan_hrm/Screens/NOC%20Certificate/empty_certificate.dart';
import 'package:maan_hrm/Screens/Notice%20Board/empty_notice_board.dart';
import 'package:maan_hrm/Screens/Payroll%20Management/management_screen.dart';
import 'package:maan_hrm/Screens/Settings/settings_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:time_chart/time_chart.dart';
import 'package:intl/intl.dart';
import '../GlobalComponents/NetworkConnectivity.dart';
import '../GlobalComponents/PreferenceManager.dart';
import '../GlobalComponents/Tools.dart';
import '../PartyList/MyPartyListPage.dart';
import '../achivementDetailsPage.dart';
import '../constant.dart';
import '../viewOrders.dart';
import '../Screens/Authentication/select_type.dart';
import '../Screens/Authentication/sign_in.dart';
import '../Screens/NotificationScreen.dart';
import '../Screens/stats_page.dart';
import '../Screens/Home/leaderBoard.dart';

import 'package:http/http.dart'as http;

import 'Approval/Approval_Menu.dart';
import 'RSM_Primary_Sales/RSM_PRIMARY_SALES_MENU.dart';


class RSM_HomeScreen extends StatefulWidget {
  RSM_HomeScreen({Key? key}) : super(key: key);

  @override
  _RSM_HomeScreenState createState() => _RSM_HomeScreenState();
}

class _RSM_HomeScreenState extends State<RSM_HomeScreen> {
  String? RoleType;

  String? token;

  String? distributorName;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};
  String isConnect = '';
  bool idLoading=false;
  Tools? tools;

  bool? isOffline;

  String? companyId;

  String? factoryId;

  String? userId;

  String? coCode;

  String? clientUrl;

  var poList;

  String? distributorId;

  String? Price_id;
  @override
  void initState() {
    // TODO: implement initState
    tools = Tools(context);


    PreferenceManager.instance
        .getStringValue("ClintUrl")
        .then((value) => setState(() {
      clientUrl = value;
      print(value);
    }));

    CheckUserConnection().then((value) {
      if(ActiveConnection==true){
        PreferenceManager.instance
            .getStringValue("Role_Type")
            .then((value) => setState(() {
          RoleType=value;
          print(value);
        }));
        PreferenceManager.instance
            .getStringValue("distributorName")
            .then((value) => setState(() {
          distributorName=value;
          print("distributorName"+value);
        }));PreferenceManager.instance
            .getStringValue("factoryId")
            .then((value) => setState(() {
          factoryId=value;
          print("factoryId"+value);
        }));
        PreferenceManager.instance
            .getStringValue("companyCode")
            .then((value) => setState(() {
          companyId=value;
          print("companyId"+value);
        }));
        PreferenceManager.instance
            .getStringValue("distributorId")
            .then((value) => setState(() {
          distributorId=value;
          print("companyId"+value);
        }));
        PreferenceManager.instance
            .getStringValue("accessToken")
            .then((value) => setState(() {
          token =Uri.encodeComponent(value.toString());
          log(token);
          setState(() {
            openHiveBox();
          });
          //fshipmaster().then((value) => fetch_polist());

        }));
      }else{
        kMainColor=Colors.red;
        Fluttertoast.showToast(
            msg: "You Are Now Offline",
            textColor: Colors.white,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      }
    });


    super.initState();
  }
  openHiveBox() async {
    var box = await Hive.openBox('erpApiMainData');
    var bookmark = box.get('erpApiMainData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        //debugPrint("erpApiMainData  ${value[0]}");
      //   setState(() {
      //     //log("TCS"+value[0]['TCS_Applicable']);
      //     PreferenceManager.instance
      //         .setStringValue("TCS_Applicable", value[0]['TCS_Applicable']);
      //     //fpricelist(value[0]['Price_id'],value[0]['Factory_id']);
      //   });
       }
    });
  }
  bool ActiveConnection =false ;
  String T = "";

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    CheckUserConnection();
    //DateTime today = DateTime.now();
    //String dateStr = "${today.day}-${today.month}-${today.year}";
    DateTime now = DateTime.now();
    String dateStr = DateFormat.yMMMEd().format(now);

    return WillPopScope(
      onWillPop: () {
        confirmationDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kMainColor,
        appBar: AppBar(
          backgroundColor: kMainColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Urmin RSM',
            maxLines: 2,
            style: kTextStyle.copyWith(color: Colors.white, fontSize: 16.0),
          ),
          actions: [
            ActiveConnection ? Container() : Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Image(
                color: Colors.white,
                height: 30,
                width: 30,
                image: AssetImage('images/wifi.png'),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: context.height() / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                  color: kMainColor,
                ),
                child: Column(
                  children: [
                    Container(
                      height: context.height() / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: kMainColor,
                              backgroundImage: AssetImage(
                                'images/Pro.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              distributorName.toString(),
                              style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   'Admin',
                            //   style: kTextStyle.copyWith(color: kGreyTextColor),
                            // ),
                          ],
                        ).onTap(() {
                          ProfileScreen().launch(context);
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '27',
                              style: kTextStyle.copyWith(color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Orders',
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '12',
                              style: kTextStyle.copyWith(color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Clients',
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '50,000',
                              style: kTextStyle.copyWith(color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Total Collection',
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  ProfileScreen().launch(context);
                },
                leading: Icon(
                  Icons.person,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Profile',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              ListTile(
                onTap: () {
                  LeaderBoard().launch(context);
                },
                leading: Icon(
                  Icons.score,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Leader Board',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
              // ListTile(
              //   onTap: () {
              //      PricingScreen().launch(context);
              //   },
              //   leading:  Icon(
              //     FontAwesomeIcons.medal,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'Premium Version   (Pro)',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing:  Icon(
              //     Icons.arrow_forward_ios,
              //     color: kGreyTextColor,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //      EmptyHoliday().launch(context);
              //   },
              //   leading:  Icon(
              //     FontAwesomeIcons.coffee,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'Holiday',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing:  Icon(
              //     Icons.arrow_forward_ios,
              //     color: kGreyTextColor,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //      EmptyHoliday().launch(context);
              //   },
              //   leading:  Icon(
              //     FontAwesomeIcons.lock,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'App Lock',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing: Transform.scale(
              //     scale: 0.6,
              //     child: CupertinoSwitch(
              //       value: isChecked,
              //       thumbColor: kGreyTextColor,
              //       onChanged: (bool value) {
              //         setState(() {
              //           isChecked = value;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     setState(() {
              //       Share.share('check out This Awesome HRM');
              //     });
              //   },
              //   leading:  Icon(
              //     FontAwesomeIcons.userFriends,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'Share With Friends',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing:  Icon(
              //     Icons.arrow_forward_ios,
              //     color: kGreyTextColor,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //      TermsOfServices().launch(context);
              //   },
              //   leading:  Icon(
              //     FontAwesomeIcons.infoCircle,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'Terms of Services',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing:  Icon(
              //     Icons.arrow_forward_ios,
              //     color: kGreyTextColor,
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //    //  PrivacyPolicy().launch(context);
              //   },
              //   leading:  Icon(
              //     Icons.dangerous_sharp,
              //     color: kGreyTextColor,
              //   ),
              //   title: Text(
              //     'Privacy Policy',
              //     style: kTextStyle.copyWith(color: kGreyTextColor),
              //   ),
              //   trailing:  Icon(
              //     Icons.arrow_forward_ios,
              //     color: kGreyTextColor,
              //   ),
              // ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                leading: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: kGreyTextColor,
                ),
                title: Text(
                  'Logout',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: kGreyTextColor,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            height: context.height(),
            padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: idLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
              physics: ClampingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Material(
                  elevation: 2,
                  child: Container(
                    width: context.width(),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color(0xFF4CE364),
                          width: 3.0,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'R S M',
                              style: kTextStyle,
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '30 May, 2021 ',
                                    style: kTextStyle.copyWith(
                                      color: kGreyTextColor,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0,
                                      bottom: 10.0,
                                      left: 10.0,
                                      right: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          color: kMainColor,
                                        )),
                                    color: kMainColor.withOpacity(0.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        '18982',
                                        style: kTextStyle.copyWith(
                                            color: kMainColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Total Purchase Order',
                                        style: kTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0,
                                      bottom: 10.0,
                                      left: 10.0,
                                      right: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          color: Color(0xFF4CE364),
                                        )),
                                    color: Color(0xFF4CE364).withOpacity(0.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        '2',
                                        style: kTextStyle.copyWith(
                                            color: Color(0xFF4CE364),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Pending Purchase Order',
                                        style: kTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0,
                                      bottom: 10.0,
                                      left: 10.0,
                                      right: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          color: Color(0xFFFD72AF),
                                        )),
                                    color: Color(0xFFFD72AF).withOpacity(0.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        '2',
                                        style: kTextStyle.copyWith(
                                            color: Color(0xFF4CE364),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Pending Purchase Order',
                                        style: kTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Expanded(
                        //       child: Padding(
                        //         padding: EdgeInsets.all(5.0),
                        //         child: Container(
                        //           padding: EdgeInsets.only(top: 10.0,
                        //               bottom: 10.0,
                        //               left: 10.0,
                        //               right: 20.0),
                        //           decoration: BoxDecoration(
                        //             border: Border(
                        //                 top: BorderSide(
                        //                   color: kMainColor,
                        //                 )),
                        //             color: kMainColor.withOpacity(0.1),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment
                        //                 .start,
                        //             children: [
                        //               Text(
                        //                 '18982',
                        //                 style: kTextStyle.copyWith(
                        //                     color: kMainColor,
                        //                     fontSize: 18.0,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 'Total GRN',
                        //                 style: kTextStyle,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Padding(
                        //         padding: EdgeInsets.all(5.0),
                        //         child: Container(
                        //           padding: EdgeInsets.only(top: 10.0,
                        //               bottom: 10.0,
                        //               left: 10.0,
                        //               right: 20.0),
                        //           decoration: BoxDecoration(
                        //             border: Border(
                        //                 top: BorderSide(
                        //                   color: Color(0xFF4CE364),
                        //                 )),
                        //             color: Color(0xFF4CE364).withOpacity(0.1),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment
                        //                 .start,
                        //             children: [
                        //               Text(
                        //                 '2',
                        //                 style: kTextStyle.copyWith(
                        //                     color: Color(0xFF4CE364),
                        //                     fontSize: 18.0,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 'Pending GRN',
                        //                 style: kTextStyle,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Padding(
                        //         padding: EdgeInsets.all(5.0),
                        //         child: Container(
                        //           padding: EdgeInsets.only(top: 10.0,
                        //               bottom: 10.0,
                        //               left: 10.0,
                        //               right: 20.0),
                        //           decoration: BoxDecoration(
                        //             border: Border(
                        //                 top: BorderSide(
                        //                   color: Color(0xFFFD72AF),
                        //                 )),
                        //             color: Color(0xFFFD72AF).withOpacity(0.1),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment
                        //                 .start,
                        //             children: [
                        //               Text(
                        //                 '2',
                        //                 style: kTextStyle.copyWith(
                        //                     color: Color(0xFF4CE364),
                        //                     fontSize: 18.0,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 'Pending GRN',
                        //                 style: kTextStyle,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Material(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: () {
                            RSM_PRIMARY_SALES_MENU().launch(context);
                          },
                          child: Container(
                            width: context.width(),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFF7C69EE),
                                  width: 3.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage('images/sales.png'),
                                  height: 50,
                                  width: 50,),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Primary Sales',
                                    style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Material(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: () {
                            APPROVAL_MENU().launch(context);
                          },
                          child: Container(
                            width: context.width(),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFFFD72AF),
                                  width: 3.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(
                                    'images/material-management.png'),
                                    width: 50,
                                    height: 50),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Approval',
                                    style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
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
                  children: [
                    Expanded(
                      flex: 1,
                      child: Material(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: () {
                            //SECONDERY_SALES_MENU().launch(context);
                          },
                          child: Container(
                            width: context.width(),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFF7C69EE),
                                  width: 3.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage('images/sales.png'),
                                  height: 50,
                                  width: 50,),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Setting',
                                    style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20.0,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Material(
                    //     elevation: 2.0,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         //VAN_SALES_MENU().launch(context);
                    //       },
                    //       child: Container(
                    //         width: context.width(),
                    //         padding: EdgeInsets.all(10.0),
                    //         decoration: BoxDecoration(
                    //           border: Border(
                    //             left: BorderSide(
                    //               color: Color(0xFFFD72AF),
                    //               width: 3.0,
                    //             ),
                    //           ),
                    //           color: Colors.white,
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Image(image: AssetImage('images/vanSales.png'),
                    //                 width: 50,
                    //                 height: 50),
                    //             Padding(
                    //               padding: EdgeInsets.all(8.0),
                    //               child: Text(
                    //                 'Van Sales',
                    //                 style: kTextStyle.copyWith(
                    //                     color: kTitleColor,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  elevation: 2.0,
                  child: Container(
                    width: context.width(),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color(0xFF4CCEFA),
                          width: 3.0,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        //  pendingGRNMainScreen().launch(context);
                      },
                      leading: Image(
                        image: AssetImage('images/ordertobill.png'),
                        height: 40,
                        width: 40,),
                      title: Text(
                        'Retailer Order',
                        maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          kMainColor = Color(0xFF2957a4);
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        kMainColor = Colors.red;
        T = "Turn On the data and repress again";
      });
    }
  }

  void confirmationDialog(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(

          // title: TextStyleExample(name : 'Privacy',style : textTheme.titleMedium!.copyWith(color: MyColors.black, fontWeight: FontWeight.bold)),
          title:  Text("Exit!"),
          content:  Text("Are you sure want to exit?",
              style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child:  Text("Cancel"),
              //child: TextStyleExample(name : 'DISAGREE',style : textTheme.labelLarge!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // child: TextStyleExample(name : 'AGREE',style : textTheme.labelLarge!.copyWith(color: MyColors.accentDark)),
              child:  Text("Sure"),
              onPressed: () {

                SystemNavigator.pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> fetch_polist() async {
    //clientUrl="https://demo.datanote.co.in/urminapi/";
    /*   isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId").toString();
    token = Uri.encodeComponent(prefs.getString("token").toString());
    co_code = prefs.getString("co_code").toString();*/
    idLoading = true;

    var dio = Dio();
    Map<String, dynamic> payload = {
      "Co_Code": companyId,
      "User_Id": distributorId,
      "Access_Token": token
    };

    print("${clientUrl}EntryList/GetPoList$payload");
    var res = await dio.get("${clientUrl}EntryList/GetPoList",
        //data: formData,
        queryParameters: payload,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    print('---- status code: ${res.statusCode}');
    setState(() {
      idLoading = false;
    });
    if (res.statusCode == 200) {
      /*     isLoading = false;*/
      var json = jsonDecode(res.data);
      log("OtpRES" + json['message'].toString());
      if (json['message'].toString() == "User Id or Token is Invalid.") {
        Fluttertoast.showToast(
            msg: "LogOut",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.push(
        // context,
        // MaterialPageRoute(builder: (context) =>  SignIn()),
        // );
      } else {
        setState(() {
          idLoading = false;
        });
        var box = Hive.box('poList');
        box.put('poList', json['message']);
        await Hive.openBox('poList');
        poList = box.get('poList');
        log("POLIST" + poList.toString());
        // bookmark.forEach((key, value) {
        //   if(key=='docs')  {
        //     debugPrint("fshipmasterData $value");
        //   }
        // });
        // for(var i = 0; i < json['message'].length; i++) {
        //
        //   if (json['message'][i]['PO_Status']=="Draft"){
        //     poList = json['message'];
        //   }
        //   // children.add(new ListTile());
        // }
      }


      Future<void> fshipmaster() async {
        setState(() {
          idLoading = true;
        });

        // Replace with your actual API URL
        String apiUrl = 'https://api.urmingroup.co.in/fshipmaster/_find';

        // Replace with your actual authorization key
        String authorizationKey =
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

        // Replace with your actual request payload
        Map<String, dynamic> requestPayload = {
          "selector": {"Distributor_id": distributorId}
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
          setState(() {
            idLoading = false;
          });
          // Check the response status
          if (response.statusCode == 200) {
            setState(() {
              idLoading = false;
            });
            Map<String, dynamic> responseBody = json.decode(response.body);

            //debugPrint("responseBody $responseBody");
            final body = jsonDecode(response.body);
            debugPrint("responseBody fshipmaster ${body}");

            var box = Hive.box('fshipmasterData');
            box.put('fshipmasterData', body);
            await Hive.openBox('fshipmasterData');
            Map<String, dynamic> bookmark = box.get('fshipmasterData');
            bookmark.forEach((key, value) {
              if (key == 'docs') {
                debugPrint("fshipmasterData $value");
              }
            });
          } else {
            setState(() {
              idLoading = false;
            });
            // Handle error
            print('API call failed with status code: ${response.statusCode}');
            print(response.body);
          }
        } catch (error) {
          setState(() {
            idLoading = false;
          });
          // Handle any exceptions
          print('Error making API call: $error');
        }
      }
    }
  }
}