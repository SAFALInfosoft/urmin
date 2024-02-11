import 'dart:core' show String, double, int, override;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'constant.dart';


class OrderDetailsPage extends StatefulWidget {


   OrderDetailsPage(
      {Key? key})
      : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderNewPageState();
}

class _OrderNewPageState extends State<OrderDetailsPage> {
  double _height = 0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'Order Details',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: Container(
        height: context.height(),
        padding:  EdgeInsets.all(20.0),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Order ID        :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "OA-1234",
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Order date   :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "25/10/2023",
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Shop Name  :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Abc Shop",
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Party Name  :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Nakul Parmar",
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Route Name  :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ahmedabad Route",
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Text(
                          "Summary  :",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                         SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "0000",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding:  EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text(
                            "URN NO        :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                           SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Abcd",
                            style:  TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Padding(
                  padding:  EdgeInsets.all(10.0),
                  child:/* widget.data != null
                      ? buildOrderDueDataListing(context, widget.data)
                      :*/ Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
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
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:  EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Total ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            Text(
              "0.0",
              style:  TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
  // Widget buildOrderDueDataListing(
  //     BuildContext context,
  //     OrderDetailsListData data,
  //     ) {
  //   return ListView.builder(
  //       physics:  ClampingScrollPhysics(),
  //       padding: EdgeInsets.zero,
  //       shrinkWrap: true,
  //       itemCount: data.items != null ? data.items?.length : 0,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //             elevation: 5,
  //             margin:
  //              EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
  //             child: customMenuItem(data.items![index]));
  //       });
  // }
  //
  // Widget customMenuItem(OrderDetailsItem data) {
  //   return Padding(
  //     padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             data.itemName.toString(),
  //             style:  TextStyle(
  //               fontWeight: FontWeight.w700,
  //               fontSize: 14.0,
  //             ),
  //           ),
  //         ),
  //         // ignore: prefer_const_constructors
  //         SizedBox(height: 3),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //              Text(
  //               'Quantity :',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //              SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               data.qty.toString(),
  //               style:  TextStyle(
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ],
  //         ),
  //          SizedBox(height: 3),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //              Text(
  //               'Rate :',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //              SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               data.rate.toString(),
  //               style:  TextStyle(
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //           ],
  //         ),
  //          SizedBox(height: 3),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //              Text(
  //               'Amount :',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 14.0,
  //               ),
  //             ),
  //              SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               data.amount.toString(),
  //               style:  TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 14.0,
  //                   color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('_height', _height));
  }

  onClick(String p1) {}
}