// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Expense%20Management/expense_list.dart';
import 'package:maan_hrm/constant.dart';
import 'package:multiselect/multiselect.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

import 'afterCheckinMainPage.dart';
class PaymentCollectionForParty extends StatefulWidget {
  const PaymentCollectionForParty({Key? key}) : super(key: key);

  @override
  _PaymentCollectionForPartyState createState() => _PaymentCollectionForPartyState();
}

class _PaymentCollectionForPartyState extends State<PaymentCollectionForParty> {

  String purpose = 'Cheque';
  bool selection = false;
  List<String> selected = [];

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  bool isVisible = false;bool isVisible1 = true;

  var DayType="Full Day";

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
    _selectTime(context).dispose();
  }


  DropdownButton<String> getLeaveType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in paymentModes) {
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

  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    setState(() {
      selectedTime = timeOfDay!;
      timeController.text = "${selectedTime.hour}:${selectedTime.minute}";
      //timeController.text=selectedTime.toString();
      log("${selectedTime.minute}:${selectedTime.hour}");
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
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Payment Collection',
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: context.height(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        //addNewOrderPage().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF7D6AEF),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Shop: Abc Shop',
                                    style: kTextStyle,
                                  ),
                                  const Spacer(),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$dateStr',
                                          style: kTextStyle.copyWith(
                                            color: kGreyTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1.0,
                                color: kGreyTextColor,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text('Pending Payment'),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('ToDay`s Order'),
                                      // Text('Sub Total'),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text('  \u{20B9} 15,000'),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text('  \u{20B9} 00'),

                                      //Text('  \u{20B9} 8,200')
                                    ],
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
                  SizedBox(
                    height: 60.0,
                    child: FormField(
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              labelText: 'Mode of payment',
                              labelStyle: kTextStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(
                              child: getLeaveType()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration: const InputDecoration(
                      labelText: 'Payment Reference number',
                      // hintText: '543223',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      readOnly: true,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: 'Choose File',
                        hintText: 'No File Chosen',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Image.asset('images/choosefile.png'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    decoration: const InputDecoration(
                      labelText: 'Remarks',
                      // hintText: '543223',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Save',
                    buttonDecoration:
                    kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const afterCheckinMainPage(),));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
