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

import '../DMS_DashBoard.dart';
import 'PO/pendingPO.dart';
import 'PO/po_Tab_View.dart';
import 'PO/purchaseOrderMainScreen.dart';
import 'PaymentDetails/payment_details_tabPage.dart';
import 'PendingGRN/pendingGRNMainScreen.dart';
import 'Salse Return/SalseReturnMainScreen.dart';


class PRIMARY_SALES_MENU extends StatefulWidget {
   PRIMARY_SALES_MENU({Key? key}) : super(key: key);

  @override
  _PRIMARY_SALES_MENUState createState() => _PRIMARY_SALES_MENUState();
}

class _PRIMARY_SALES_MENUState extends State<PRIMARY_SALES_MENU> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        return await Navigator.push(context,  MaterialPageRoute(builder: (context) =>
            Dms_HomeScreen()));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kMainColor,
        appBar: AppBar(
          backgroundColor: kMainColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme:  IconThemeData(color: Colors.white),
          title: Text(
            'Primary Sales',
            maxLines: 2,
            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Container(
                padding:  EdgeInsets.all(20.0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [

                    Material(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          po_Tab_View().launch(context);
                        },
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
                            leading:  Image(image: AssetImage('images/add-to-cart (1).png'),height: 40,width: 40,),
                            title: Text(
                              'Purchase Order',
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
                            payment_details_tabPage().launch(context);
                          },
                          leading:  Image(image: AssetImage('images/payment_details.png'),height: 40,width: 40,),
                          title: Text(
                            'Payment Details',
                            maxLines: 2,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          trailing:  Icon(Icons.arrow_forward_ios),
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
                             pendingGRNMainScreen().launch(context);
                          },
                          leading:  Image(image: AssetImage('images/pendingGRN.png'),height: 40,width: 40,),
                          title: Text(
                            'Pending GRN',
                            maxLines: 2,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          trailing:  Icon(Icons.arrow_forward_ios),
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
                             SalseReturnMainScreen().launch(context);
                          },
                          leading:  Image(image: AssetImage('images/reverse.png'),height: 40,width: 40,),
                          title: Text(
                            'Sales Return',
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

      ),
    );
  }
}
