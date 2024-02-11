// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class EmployeeOvertimeDetails extends StatefulWidget {
   EmployeeOvertimeDetails({Key? key}) : super(key: key);

  @override
  _EmployeeOvertimeDetailsState createState() => _EmployeeOvertimeDetailsState();
}

class _EmployeeOvertimeDetailsState extends State<EmployeeOvertimeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: ListTile(
          leading: Image.asset('images/emp1.png'),
          title: Text(
            'Sahidul Islam',
            style: kTextStyle.copyWith(color: Colors.white),
          ),
          subtitle: Text(
            'Designer',
            style: kTextStyle.copyWith(color: Colors.white),
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
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
                color: kBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Date',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Hours',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Amount',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                         Divider(
                          thickness: 1.0,
                          color: kGreyTextColor,
                        ),
                         SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '10-06-2021',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '1 Hour 30 min',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$1000',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                          ],
                        ),
                         Divider(
                          thickness: 1.0,
                          color: kGreyTextColor,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Total',
                                style: kTextStyle.copyWith(color: kTitleColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '1 Hour 30 min',
                                style: kTextStyle.copyWith(color: kTitleColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$1000',
                                style: kTextStyle.copyWith(color: kTitleColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                   Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60.0,
                          padding:  EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: kMainColor,
                          ),
                          child: Center(
                              child: Text(
                            'Delete',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                       SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 60.0,
                          padding:  EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kMainColor.withOpacity(0.1),
                          ),
                          child: Center(
                              child: Text(
                            'Edit',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                        ),
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
