// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';

class NotificationScreen extends StatefulWidget {
   NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Notifications',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Image(
                    width: 200,
                    height: 200,
                    image: AssetImage('images/empty.png'),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'Notifications are not available!',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),

                    ],
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
