// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Employee%20Overtime/empty_employee_overtime.dart';
import 'package:maan_hrm/Screens/Employee%20management/empty_employee.dart';
import 'package:maan_hrm/Screens/Leave%20Managemenr/leave_management.dart';
import 'package:maan_hrm/Screens/Reference%20Management/empty_reference.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/empty_salary_statement.dart';
import 'package:maan_hrm/Screens/Time%20Attendence/attendance_employee_list.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../constant.dart';
import '../../Screens/Employee management/add_employee.dart';
import '../../Screens/Expense Management/empty_expense.dart';



class SECONDERY_SALES_MENU extends StatefulWidget {
   SECONDERY_SALES_MENU({Key? key}) : super(key: key);

  @override
  _SECONDERY_SALES_MENUState createState() => _SECONDERY_SALES_MENUState();
}

class _SECONDERY_SALES_MENUState extends State<SECONDERY_SALES_MENU> {
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
          'Secondary Sales',
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
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        // purchaseOrderMainScreen().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding:  EdgeInsets.all(10.0),
                        decoration:  BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF7D6AEF),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          leading:  Image(image: AssetImage('images/marketplace.png'),height: 40,width: 40,),
                          title: Text(
                            'Retailer Master',
                            maxLines: 2,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          trailing:  Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: context.width(),
                      padding:  EdgeInsets.all(10.0),
                      decoration:  BoxDecoration(
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
                        leading:  Image(image: AssetImage('images/ordertobill.png'),height: 40,width: 40,),
                        title: Text(
                          'Retailer Order',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        trailing:  Icon(Icons.arrow_forward_ios),
                      ),
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
}
