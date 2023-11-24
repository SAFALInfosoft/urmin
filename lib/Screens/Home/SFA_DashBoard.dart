// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import '../../GlobalComponents/PreferenceManager.dart';
import '../../PartyList/MyPartyListPage.dart';
import '../../achivementDetailsPage.dart';
import '../../constant.dart';
import '../../viewOrders.dart';
import '../Authentication/select_type.dart';
import '../Authentication/sign_in.dart';
import '../NotificationScreen.dart';
import '../stats_page.dart';
import 'leaderBoard.dart';

// ignore_for_file: library_private_types_in_public_api
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? RoleType;

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
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    //DateTime today = DateTime.now();
    //String dateStr = "${today.day}-${today.month}-${today.year}";
    DateTime now = DateTime.now();
    String dateStr = DateFormat.yMMMEd().format(now);
    print(dateStr);
    return SafeArea(
      child: WillPopScope(
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
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              '${RoleType??''} Management',
              maxLines: 2,
              style: kTextStyle.copyWith(color: Colors.white, fontSize: 16.0),
            ),
            actions:  [
              InkWell(
                onTap: () {
                  const NotificationScreen().launch(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('images/notificationicon.png'),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  height: context.height() / 3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                    color: kMainColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: context.height() / 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              const CircleAvatar(
                                radius: 60.0,
                                backgroundColor: kMainColor,
                                backgroundImage: AssetImage(
                                  'images/Pro.png',
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Nakul Parmar',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Admin',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ],
                          ).onTap(() {
                            const ProfileScreen().launch(context);
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '27',
                                style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                                style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                                style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  onTap: () {
                    const ProfileScreen().launch(context);
                  },
                  leading: const Icon(
                    Icons.person,
                    color: kGreyTextColor,
                  ),
                  title: Text(
                    'Profile',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                     LeaderBoard().launch(context);
                  },
                  leading: const Icon(
                    Icons.score,
                    color: kGreyTextColor,
                  ),
                  title: Text(
                    'Leader Board',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     const PricingScreen().launch(context);
                //   },
                //   leading: const Icon(
                //     FontAwesomeIcons.medal,
                //     color: kGreyTextColor,
                //   ),
                //   title: Text(
                //     'Premium Version   (Pro)',
                //     style: kTextStyle.copyWith(color: kGreyTextColor),
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //     const EmptyHoliday().launch(context);
                //   },
                //   leading: const Icon(
                //     FontAwesomeIcons.coffee,
                //     color: kGreyTextColor,
                //   ),
                //   title: Text(
                //     'Holiday',
                //     style: kTextStyle.copyWith(color: kGreyTextColor),
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //     const EmptyHoliday().launch(context);
                //   },
                //   leading: const Icon(
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
                //   leading: const Icon(
                //     FontAwesomeIcons.userFriends,
                //     color: kGreyTextColor,
                //   ),
                //   title: Text(
                //     'Share With Friends',
                //     style: kTextStyle.copyWith(color: kGreyTextColor),
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //     const TermsOfServices().launch(context);
                //   },
                //   leading: const Icon(
                //     FontAwesomeIcons.infoCircle,
                //     color: kGreyTextColor,
                //   ),
                //   title: Text(
                //     'Terms of Services',
                //     style: kTextStyle.copyWith(color: kGreyTextColor),
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //    // const PrivacyPolicy().launch(context);
                //   },
                //   leading: const Icon(
                //     Icons.dangerous_sharp,
                //     color: kGreyTextColor,
                //   ),
                //   title: Text(
                //     'Privacy Policy',
                //     style: kTextStyle.copyWith(color: kGreyTextColor),
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  leading: const Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: kGreyTextColor,
                  ),
                  title: Text(
                    'Logout',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: context.height(),
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          const MyPartyList().launch(context);
                        },
                        child: Container(
                          width: context.width(),
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFFFF8919),
                                width: 3.0,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Achievements',
                                        style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        dateStr,
                                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const achivementDetailsPage(),));
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Your Performance >>',
                                            style: kTextStyle.copyWith(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 20.0),
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              top: BorderSide(
                                                color: kMainColor,
                                              )),
                                          color: kMainColor.withOpacity(0.1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '80,000',
                                              style: kTextStyle.copyWith(color: kMainColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Target',
                                              style: kTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 20.0),
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              top: BorderSide(
                                                color: Color(0xFF4CE364),
                                              )),
                                          color: const Color(0xFF4CE364).withOpacity(0.1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '50,000',
                                              style: kTextStyle.copyWith(color: const Color(0xFF4CE364), fontSize: 18.0, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Achievement',
                                              style: kTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 15.0),
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              top: BorderSide(
                                                color: Color(0xFF4ACDF9),
                                              )),
                                          color: const Color(0xFF4ACDF9).withOpacity(0.1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '35000',
                                              style: kTextStyle.copyWith(color: const Color(0xFF4ACDF9), fontSize: 18.0, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Collection',
                                              style: kTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                              const MyPartyList().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
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

                                  const Image(image: AssetImage('images/newOrder.png'),height: 50,width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Start My Route',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Material(
                          elevation: 2.0,
                          child: GestureDetector(
                            onTap: () {
                              const viewOrders().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
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
                                  const Image(image: AssetImage('images/order.png'),width: 50,height: 50),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'View Orders',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
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
                  const SizedBox(
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
                              const EmployeeManagement().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
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
                                  const Image(image: AssetImage('images/salesman.png'),height: 50,width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'SFA Management',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Material(
                          elevation: 2.0,
                          child: GestureDetector(
                            onTap: () {
                              const ExpenseManagementScreen().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
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
                                  const Image(image: AssetImage('images/expensemanagement.png'),width: 50,height: 50),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Reports',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
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
                /* const SizedBox(
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
                              const PayrollManagementScreen().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFF4ACDF9),
                                    width: 3.0,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Image(image: AssetImage('images/payrollmanagement.png')),
                                  Text(
                                    'Payroll Management',
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Material(
                          elevation: 2.0,
                          child: GestureDetector(
                            onTap: () {
                              const EmptyFileManagement().launch(context);
                            },
                            child: Container(
                              width: context.width(),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFF02B984),
                                    width: 3.0,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Image(image: AssetImage('images/filemanagement.png')),
                                  Text(
                                    ' Files Managements ',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  */
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  Visibility(
                    visible: false,
                    child: Material(
                      elevation: 2.0,
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF4DCEFA),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            const RouteManagementMenuScreen().launch(context);
                          },
                          leading: const Image(image: AssetImage('images/RouteManagement.png'),height: 40,width: 40,),
                          title: Text(
                            'Route Management',
                            maxLines: 2,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: context.width(),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFFFF8919),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                           StatsPage().launch(context);
                        },
                        leading: const Image(image: AssetImage('images/gamification.png'),height: 40,width: 40,),
                        title: Text(
                          'Market Visit',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: context.width(),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFF1CC389),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          const EmptyNoticeBoard().launch(context);
                        },
                        leading: const Image(image: AssetImage('images/paymentCollecton.png'),height: 40,width: 40,),
                        title: Text(
                          'Payment Collection',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  /*const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: context.width(),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFF8270F1),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        leading: const Image(image: AssetImage('images/awards.png')),
                        title: Text(
                          'Awards',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          title: const Text("Exit!"),
          content: const Text("Are you sure want to exit?",
              style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              //child: TextStyleExample(name : 'DISAGREE',style : textTheme.labelLarge!),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // child: TextStyleExample(name : 'AGREE',style : textTheme.labelLarge!.copyWith(color: MyColors.accentDark)),
              child: const Text("Sure"),
              onPressed: () {

                SystemNavigator.pop();
              },
            )
          ],
        );
      },
    );
  }
}
