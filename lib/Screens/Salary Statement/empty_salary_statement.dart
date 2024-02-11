// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/add_salary_statement.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';

// ignore_for_file: library_private_types_in_public_api
class EmptySalaryStatement extends StatefulWidget {
   EmptySalaryStatement({Key? key}) : super(key: key);

  @override
  _EmptySalaryStatementState createState() => _EmptySalaryStatementState();
}

class _EmptySalaryStatementState extends State<EmptySalaryStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          bool isValid = await PurchaseModel().isActiveBuyer();
          if(isValid){
             AddSalaryStatement().launch(context);
          } else{
            showLicense(context: context);
          }

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
          'Empty Salary Statement',
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
                        'Add Salary Statement',
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
