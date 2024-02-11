// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Authentication/sign_in.dart';

import '../../GlobalComponents/PreferenceManager.dart';
import '../../constant.dart';

class SelectType extends StatefulWidget {
   SelectType({Key? key}) : super(key: key);

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          confirmationDialog(context);
          return Future.value(false);
        },
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
                color: Colors.white,
                // image: DecorationImage(
                //   image: AssetImage("images/bg.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("images/logo.png"),
                    minRadius: 50,
                    maxRadius: 50,
                     ),
                   SizedBox(
                    height: 20,
                  ),
                  // Image(image: AssetImage("images/people.png")),
                  Text(
                    'Select Your Role',
                    style: kTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: kMainColor),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          PreferenceManager.instance.setStringValue(
                              "Role_Type", "DMS").then((value) =>  SignIn().launch(context));
                          PreferenceManager.instance
                              .getStringValue("Role_Type")
                              .then((value) => setState(() {
                            if (kDebugMode) {
                              print(value);
                            }
                          }));
                        },
                        leading:  Image(
                          image: AssetImage('images/employeemanagement.png'),
                          height: 40,
                          width: 40,
                        ),
                        title: Text(
                          'D M S',
                          style: kTextStyle.copyWith(fontSize: 14.0),
                        ),
                        // subtitle: Text(
                        //   'Register your company & start attendance ',
                        //   style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: kMainColor),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          PreferenceManager.instance.setStringValue(
                              "Role_Type", "SFA").then((value) =>  SignIn().launch(context));
                          PreferenceManager.instance
                              .getStringValue("Role_Type")
                              .then((value) => setState(() {
                            log(value);
                          }));
                        },
                        leading:  Image(height: 40,
                          width: 40,

                          image: AssetImage('images/salesman.png'),
                        ),
                        title: Text(
                          'S F A',
                          style: kTextStyle.copyWith(fontSize: 14.0),
                        ),
                        // subtitle: Text(
                        //   'Register and start marking your attendance',
                        //   style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
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
}
