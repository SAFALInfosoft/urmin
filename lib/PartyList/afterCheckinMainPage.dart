// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:maan_hrm/PartyList/MyPartyListPage.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';
import 'CompetitorProductInformation.dart';
import 'MarketSurvay.dart';
import 'MerchandisingActivity.dart';
import 'PaymentCollectionForParty.dart';
import 'addOrder.dart';
import 'package:intl/intl.dart';

class afterCheckinMainPage extends StatefulWidget {
   afterCheckinMainPage({Key? key}) : super(key: key);

  @override
  _afterCheckinMainPageState createState() => _afterCheckinMainPageState();
}

class _afterCheckinMainPageState extends State<afterCheckinMainPage> {
  bool visibleLessInfo = false;
  bool visibleMoreInfo = true;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dateStr = DateFormat.yMMMEd().format(now);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kMainColor,
        appBar: AppBar(
          backgroundColor: kMainColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme:  IconThemeData(color: Colors.white),
          title: Text(
            'Add New Order',
            maxLines: 2,
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                width: context.width(),
                padding:  EdgeInsets.all(20.0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: () {
                            // addNewOrderPage().launch(context);
                          },
                          child: Container(
                            width: context.width(),
                            padding:  EdgeInsets.all(0.0),
                            decoration:  BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFF7D6AEF),
                                  width: 3.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                subtitle: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Collection Overview',
                                        style: kTextStyle.copyWith(
                                          color: kGreyTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  'Shop: Abc Shop',
                                  style: kTextStyle,
                                ),
                                children: [Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     RichText(
                                      //       text: TextSpan(
                                      //         children: [
                                      //           TextSpan(
                                      //             text: '$dateStr',
                                      //             style: kTextStyle.copyWith(
                                      //               color: kGreyTextColor,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //      Spacer(),
                                      //   ],
                                      // ),
                                       Divider(
                                        thickness: 1.0,
                                        color: kGreyTextColor,
                                      ),
                                       SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:  <Widget>[
                                              Text('ToDay`s Order'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text('Pending Payment'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text('Current Monthly Order'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                               Text(
                                                  'Current Monthly Collection'),
                                               SizedBox(
                                                height: 5.0,
                                              ),
                                               Text('Average Monthly Order'),
                                               SizedBox(
                                                height: 5.0,
                                              ),
                                               Text(
                                                  'Average Monthly Collection'),
                                               SizedBox(
                                                height: 10.0,
                                              ),
                                              // Text('Sub Total'),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:  <Widget>[
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
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text('  \u{20B9} 29,000'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text('  \u{20B9} 20,000'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(''),

                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),]
                              ),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: () {
                             addNewOrderPage().launch(context);
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
                              leading:  Image(
                                image: AssetImage('images/add-to-cart (1).png'),
                                height: 40,
                                width: 40,
                              ),
                              title: Text(
                                'Add New Order',
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
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
                        child: GestureDetector(
                          onTap: () {
                             PaymentCollectionForParty().launch(context);
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
                              leading:  Image(
                                image:
                                    AssetImage('images/paymentCollecton.png'),
                                height: 40,
                                width: 40,
                              ),
                              title: Text(
                                'Payment Collection',
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
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
                        child: GestureDetector(
                          onTap: () {
                             MarketSurvey().launch(context);
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
                              leading:  Image(
                                image: AssetImage('images/market-survay.png'),
                                height: 40,
                                width: 40,
                              ),
                              title: Text(
                                'Market Survey',
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
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
                        child: GestureDetector(
                          onTap: () {
                            MerchandisingActivity().launch(context);
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
                              leading:  Image(
                                image: AssetImage(
                                    'images/merchandisingActivity.png'),
                                height: 40,
                                width: 40,
                              ),
                              title: Text(
                                'Merchandising Activity',
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
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
                        child: GestureDetector(
                          onTap: () {
                            CompetitorProductInformation().launch(context);
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
                              leading:  Image(
                                image: AssetImage(
                                    'images/merchandisingActivity.png'),
                                height: 40,
                                width: 40,
                              ),
                              title: Text(
                                'Competitor Product Information',
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing:  Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding:  EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10, bottom: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  MyPartyList(),
                        ));
                    //onNextPageChangeTapped();
                  });
                },
                child: Container(
                  //width: 100.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child:  Center(
                    child: Text(
                      'Check Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins_regular',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
