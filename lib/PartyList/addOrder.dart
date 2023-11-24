// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';
import 'afterCheckinMainPage.dart';

class addNewOrderPage extends StatefulWidget {
  const addNewOrderPage({Key? key}) : super(key: key);

  @override
  _addNewOrderPageState createState() => _addNewOrderPageState();
}

class _addNewOrderPageState extends State<addNewOrderPage> {
  int qty = 1;
  int items = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Add New Order',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      autocorrect: true,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items,
                        itemBuilder: (ctx, itemIndex) {
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                             // height: 65,
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage("https://urminstore.com/pub/media/catalog/product/cache/835e48150b5844ff4116c639e4c3d879/f/a/farali-tikha-front.jpg")),
                                        border:
                                        Border.all(color: Colors.grey, width: 1),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10, right: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children:  <Widget>[
                                              Flexible(
                                                child: Text('Bansiram FARALI CHIWDA TIKHA (350 G)',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right: 4),
                                                child: Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          color: Colors.green,
                                                          size: 25,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          qty > 0 ? qty.toString() : '100',
                                                          style: TextStyle(fontSize: 16),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10, right: 7,top: 5),
                                          child: Text(
                                            '\u{20B9} 50',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  // Container(
                  //   height: 200,
                  //   padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children:  <Widget>[
                  //       TextField(
                  //           obscureText: true,
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             labelText: 'Promo Code',
                  //           )),
                  //       Expanded(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Column(
                  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text('Shipping'),
                  //                 Text('Offer'),
                  //                 Text('Tax'),
                  //                 Text('Sub Total'),
                  //               ],
                  //             ),
                  //             Column(
                  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text('  \u{20B9} 80'),
                  //                 Text('- \u{20B9} 100'),
                  //                 Text('  \u{20B9} 1,799'),
                  //                 Text('  \u{20B9} 8,200')
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text('Place Order \u{20B9} 100',
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => afterCheckinMainPage(),));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    kMainColor)),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
