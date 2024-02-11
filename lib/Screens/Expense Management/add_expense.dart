// ignore_for_file: library_private_types_in_public_api
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/ExpanseForm/multi_form.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Expense%20Management/expense_list.dart';
import 'package:maan_hrm/Screens/Expense%20Management/tansaction.dart';
import 'package:maan_hrm/Screens/Expense%20Management/transaction_list.dart';
import 'package:maan_hrm/constant.dart';
import 'package:multiselect/multiselect.dart';
import 'package:nb_utils/nb_utils.dart';

import 'new_transaction.dart';

class AddExpense extends StatefulWidget {
   AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String employee = 'Sahidul Islam';
  String type = 'Ticket';
  String purpose = 'Privilege Leave (PL)';
  bool selection = false;
  List<String> selected = [];

  final dateController = TextEditingController();
  final startTownController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  DropdownButton<String> getType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in ExpanseType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: type,
      onChanged: (value) {
        setState(() {
          type = value!;
        });
      },
    );
  }

  DropdownButton<String> getPurpose() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in expensePurpose) {
      var item = DropdownMenuItem(
        value: gender,
        child: Text(gender),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: purpose,
      onChanged: (value) {
        setState(() {
          purpose = value!;
        });
      },
    );
  }
  final List<Transaction> _userTransaction = [];
  void _addTransaction(var lable, var amount) {
    var addTx = Transaction(
      lable: lable,
      amount: amount,
      Date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(addTx);
    });
  }

  void _addNewTransactionModel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void _deleteTransaction(var id){
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dateStr = DateFormat.yMMMEd().format(now);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => MultiForm(),));
      //   },
      // ),
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Add Expense',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
              ),
              child: ListTile(
                leading: Image.asset('images/Pro.png'),
                title: Text(
                  'Name: Nakul Parmar',
                  style: kTextStyle.copyWith(color: Colors.black),
                ),
                subtitle: Text(
                  '$dateStr',
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:  Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration:  InputDecoration(
                      labelText: 'Start Town',
                      hintText: 'Town',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: AppTextField(
                    textFieldType: TextFieldType.NAME,
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                      dateController.text = date.toString().substring(0, 10);
                    },
                    controller: dateController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Icon(
                          Icons.date_range_rounded,
                          color: kGreyTextColor,
                        ),
                        labelText: 'Start Date',
                        hintText: '03/11/2023'),
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
                  child: AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration:  InputDecoration(
                      labelText: 'End Town',
                      hintText: 'Town',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: AppTextField(
                    textFieldType: TextFieldType.NAME,
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                      dateController.text = date.toString().substring(0, 10);
                    },
                    controller: dateController,
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Icon(
                          Icons.date_range_rounded,
                          color: kGreyTextColor,
                        ),
                        labelText: 'End Date',
                        hintText: '03/11/2023'),
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 200,
                child: ButtonGlobal(
                  buttontext: 'Add New Expanse',
                  buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                  onPressed: () {
                    _addNewTransactionModel(context);
                  },
                ),
              ),
            ),
            Divider(),
            Expanded(
                child: TransactionList(_userTransaction , _deleteTransaction)),
            // Row(
            //   children: [
            //     Expanded(
            //       child: AppTextField(
            //         textFieldType: TextFieldType.PHONE,
            //         decoration:  InputDecoration(
            //           labelText: 'Ticket',
            //           hintText: 'Amount of ticket',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10,),
            //     Expanded(
            //       child: AppTextField(
            //         textFieldType: TextFieldType.PHONE,
            //         decoration:  InputDecoration(
            //           labelText: 'Private',
            //           hintText: 'Amount of Private',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //  SizedBox(
            //   height: 20.0,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: AppTextField(
            //         textFieldType: TextFieldType.PHONE,
            //         decoration:  InputDecoration(
            //           labelText: 'Local Conveyance',
            //           hintText: 'Amount of LC',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10,),
            //     Expanded(
            //       child: AppTextField(
            //         textFieldType: TextFieldType.PHONE,
            //         decoration:  InputDecoration(
            //           labelText: 'Daily Allowance',
            //           hintText: 'Amount of DA',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //  SizedBox(
            //   height: 20.0,
            // ),
            // AppTextField(
            //   textFieldType: TextFieldType.PHONE,
            //   decoration:  InputDecoration(
            //     labelText: 'Mobile Recharge',
            //     hintText: 'Amount of bill',
            //     border: OutlineInputBorder(),
            //   ),
            // ),  SizedBox(
            //   height: 20.0,
            // ),
            // AppTextField(
            //   textFieldType: TextFieldType.PHONE,
            //   decoration:  InputDecoration(
            //     labelText: 'Photo Copy',
            //     hintText: 'Amount of Photo Copy',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            //  SizedBox(
            //   height: 20.0,
            // ),
            // AppTextField(
            //   textFieldType: TextFieldType.PHONE,
            //   decoration:  InputDecoration(
            //     labelText: 'Stationary',
            //     hintText: 'Amount of Stationary',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            //  SizedBox(
            //   height: 20.0,
            // ),
            // AppTextField(
            //   textFieldType: TextFieldType.PHONE,
            //   decoration:  InputDecoration(
            //     labelText: 'Expense Amount',
            //     hintText: '\$223',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            //  SizedBox(
            //   height: 20.0,
            // ),
            // AppTextField(
            //   textFieldType: TextFieldType.PHONE,
            //   decoration:  InputDecoration(
            //     labelText: 'Currier',
            //     hintText: 'Amount of Currier',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
             SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child:Icon(Icons.check),
          onPressed: () {
                //ExpenseList().launch(context)
          }),
    );
  }
}
