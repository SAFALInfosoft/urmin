// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Employee%20management/add_employee.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class EmptyEmployeeScreen extends StatefulWidget {
   EmptyEmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmptyEmployeeScreenState createState() => _EmptyEmployeeScreenState();
}

class _EmptyEmployeeScreenState extends State<EmptyEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           AddEmployee().launch(context);
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
          'Empty Employee',
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
                        'Add your employee',
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
