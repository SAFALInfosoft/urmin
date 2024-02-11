// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Client%20Management/add_client.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class EmptyClientList extends StatefulWidget {
   EmptyClientList({Key? key}) : super(key: key);

  @override
  _EmptyClientListState createState() => _EmptyClientListState();
}

class _EmptyClientListState extends State<EmptyClientList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           AddClient().launch(context);
        },
        backgroundColor: kMainColor,
        child:  Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Empty Client',
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
                    image: AssetImage('images/empty.png'),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'No Data',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Text(
                        'Add your client',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
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
