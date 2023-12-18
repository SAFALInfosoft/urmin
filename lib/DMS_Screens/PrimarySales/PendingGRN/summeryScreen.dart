import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../GlobalComponents/button_global.dart';
import '../../../constant.dart';



class OrderSummaryScreen extends StatefulWidget {
  // final OrderDetailsListData data;
  // final String? routeName;
  // final Function(String) onSubmitCallBack;
  // final Function onCancelCallBack;

  const OrderSummaryScreen(
      {Key? key,
       /* required this.data,
        required this.routeName,
        required this.onSubmitCallBack*/
        /*required this.onCancelCallBack*/})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OrderSummaryScreen> {
  String summary = '';
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
    return AlertDialog(
      title: const Text('Order Summary'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      actions: <Widget>[
        const SizedBox(height: 20.0),
        Row(
          children: [
            Flexible(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color(0xFF555555),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'poppins_regular'),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                 // widget.onCancelCallBack();
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color(0XFF6883BC),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'poppins_regular'),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () =>
                {/*widget.onSubmitCallBack(summary),*/ Navigator.pop(context)},
              ),
            ),
          ],
        )
      ],
      content: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text('Net Total'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('Charges'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('Roundoff'),
                      SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                          'Grand Total'),

                      // Text('Sub Total'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text('  \u{20B9} 00'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('  \u{20B9} 5,000'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('  \u{20B9} 45,000'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('  \u{20B9} 10,000'),


                    ],
                  ),
                ],
              ),
              const Divider(),
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                              image: AssetImage(
                                'images/empty.png',
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Order item list not found",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "poppins_regular",
                            fontWeight: FontWeight.w900,
                            fontSize: 17.0),
                      )
                    ],
                        ),
                      ),
              const Divider(),
              // ConstrainedBox(
              //   constraints: BoxConstraints(
              //     maxHeight: MediaQuery.of(context).size.height * 0.4,
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //         color: Colors.white,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Order ID        :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.orderNo".toString(),
              //                   style: const TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Order date   :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.orderDate".toString(),
              //                   style: const TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Shop Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                   "widget.data.party".toString(),
              //                   style: const TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Party Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(
              //                  " widget.data.shopName".toString(),
              //                   style: const TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Route Name  :",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 Flexible(
              //                   child: Text(
              //                     "widget.routeName".toString(),
              //                     overflow: TextOverflow.visible,
              //
              //                     style: const TextStyle(
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.w500,
              //                       fontSize: 14.0,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Visibility(
              //               visible: false,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(
              //                     left: 20, right: 20, top: 5, bottom: 10),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       "URN NO        :",
              //                       style: TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w600,
              //                         fontSize: 14.0,
              //                       ),
              //                     ),
              //                     const SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                      " widget.data.uRNNo".toString(),
              //                       style: const TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 14.0,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child:/* widget.data != null
              //             ? buildOrderDueDataListing(context,*//* widget.data*//*)
              //             : */Align(
              //           alignment: Alignment.center,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: const [
              //               SizedBox(
              //                   height: 100,
              //                   width: 100,
              //                   child: Image(
              //                       image: AssetImage(
              //                         'images/empty.png',
              //                       ))),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 "Order item list not found",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontFamily: "poppins_regular",
              //                     fontWeight: FontWeight.w900,
              //                     fontSize: 17.0),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
               // height: context.height(),
                //padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
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

                    // ButtonGlobal(
                    //   buttontext: 'Save',
                    //   buttonDecoration:
                    //   kButtonDecoration.copyWith(color: kMainColor),
                    //   onPressed: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const afterCheckinMainPage(),));
                    //   },
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                autofocus: false,
                maxLines: 3,
                onChanged: (value) {
                  summary = value;
                  setState(() {});
                },
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),],
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Add Summary",

                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey)),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

/*  Widget buildOrderDueDataListing(
      BuildContext context,
      *//*OrderDetailsListData data,*//*
      ) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: *//*data.items != null ? data.items?.length :*//* 0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin:
              const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: customMenuItem(data.items![index]));
        });
  }

  Widget customMenuItem(*//*OrderDetailsItem data*//*) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              data.itemName.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Quantity :',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                data.qty.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Rate :',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                data.rate.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Amount :',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                data.amount.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }*/
}
