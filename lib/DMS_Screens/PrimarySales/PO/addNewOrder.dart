

// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart'as http;
import '../../../constant.dart';
import '../PendingGRN/summeryScreen.dart';

class addNewOrderForPo extends StatefulWidget {
  const addNewOrderForPo({Key? key}) : super(key: key);

  @override
  _addNewOrderForPoState createState() => _addNewOrderForPoState();
}


class _addNewOrderForPoState extends State<addNewOrderForPo> {
  int qty = 1;
  List fpricelist_Items=[];
  String dropdownValue = 'Uom'; String dropdownValue0 = 'Carton';

  bool idLoading= false;

  List ItemmasterData=[];
  @override
  void initState() {
    fpricelist();
    fshipmaster();
    fitemmaster();
    // TODO: implement initState
    super.initState();
  }
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
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Chikki', 'Khakhra', 'Krunchips','Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue0,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue0 = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Food Products', 'Tingels Jaljira', 'Bilas Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      autocorrect: true,
                    ),
                  ),
                  idLoading?Center(child: CircularProgressIndicator()): Expanded(
                    child: ListView.builder(
                        itemCount: fpricelist_Items.length,
                        itemBuilder: (ctx, itemIndex) {
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              // height: 65,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://urminstore.com/pub/media/catalog/product/cache/835e48150b5844ff4116c639e4c3d879/f/a/farali-tikha-front.jpg")),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                        fpricelist_Items[itemIndex]['Item_name'],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 7, top: 5),
                                        child: Text(
                                          '\u{20B9} ${fpricelist_Items[itemIndex]['MRP']}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    child: Row(
                                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration.collapsed(hintText: ''),

                                              // decoration: InputDecoration(
                                              //   enabledBorder: OutlineInputBorder(
                                              //     //<-- SEE HERE
                                              //     borderSide: BorderSide(color: Colors.black,),
                                              //   ),
                                              //   focusedBorder: OutlineInputBorder(
                                              //     //<-- SEE HERE
                                              //     borderSide: BorderSide(color: Colors.black,),
                                              //   ),
                                              //   filled: true,
                                              //   // fillColor: Colors.white,
                                              // ),
                                              // dropdownColor: Colors.white,
                                              value: dropdownValue0,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue0 = newValue!;
                                                });
                                              },
                                              items: <String>['Carton', 'Unit']
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                    SizedBox(width: 5,),
                                        Flexible(
                                          child: TextFormField(
                                            keyboardType: TextInputType. number,
                                            decoration: InputDecoration(
                                            enabled: false,
                                              border: InputBorder.none,
                                              // enabledBorder: OutlineInputBorder(),
                                             // labelText: 'Nos',
                                              hintText: 'Nos',
                                            ),
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
                            child: Text('Place Order',
                                style: TextStyle(fontSize: 20,color: Colors.white)),
                            onPressed: () {
                              showSummaryDialog();
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => afterCheckinMainPage(),));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll(kMainColor)),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showSummaryDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => OrderSummaryScreen(

        ));
  }
  Future<void> fshipmaster() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fshipmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "dcbd62d4d5e6446634e5ba708be6e850"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {

        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        //debugPrint("responseBody $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fshipmaster ${body}");
        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
  Future<void> fpricelist() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fpricelist/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Company_id":"1a36b22bdd89ffd361644e6ea06c2394"
        ,"Factory_id":"8101b2c0a710849dc04f61cc3c07cb9a","Price_id":
        "9d22b8a2af022745b593bf1c740ed329"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {

        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fpricelist ${body['docs'][0]['item']}");
        fpricelist_Items=body['docs'][0]['item'];
        log("ItemCount "+fpricelist_Items.length.toString());

        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
  Future<void> fitemmaster() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fitemmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "limit": 5000,
      "selector": {"Company_id": "1a36b22bdd89ffd361644e6ea06c2394", "Factory_id": "8101b2c0a710849dc04f61cc3c07cb9a"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        //body['docs'][0]['Item_name']
        ItemmasterData = body['docs'];
        log(ItemmasterData.toString());
        for (int k = 0; k < ItemmasterData.length; k++) {
          for(int j=0; j<fpricelist_Items.length;j++){

          }
          //  debugPrint("responseBody fitemmaster ${body['docs'][k]['Status']}");
        }
        //fpricelist_Items=body['docs'][0]['item'];
        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
}




/*
// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart'as http;
import '../../../constant.dart';
import '../PendingGRN/summeryScreen.dart';

class addNewOrderForPo extends StatefulWidget {
  const addNewOrderForPo({Key? key}) : super(key: key);

  @override
  _addNewOrderForPoState createState() => _addNewOrderForPoState();
}


class _addNewOrderForPoState extends State<addNewOrderForPo> {
  int qty = 1;
  List fpricelist_Items=[];
  String dropdownValue = 'Uom'; String dropdownValue0 = 'Carton';

  bool idLoading= false;

  List ItemmasterData=[];
  @override
  void initState() {
    fpricelist();
    fshipmaster();
    fitemmaster();
    // TODO: implement initState
    super.initState();
  }
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
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                */
/*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Chikki', 'Khakhra', 'Krunchips','Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValue0,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue0 = newValue!;
                              });
                            },
                            fpricelist_Items: <String>['All', 'Food Products', 'Tingels Jaljira', 'Bilas Namkeen']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),*//*

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSearchTextField(
                      //controller: controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      autocorrect: true,
                    ),
                  ),
                  idLoading?Center(child: CircularProgressIndicator()): Expanded(
                    child: ListView.builder(
                        itemCount: fpricelist_Items.length,
                        itemBuilder: (ctx, itemIndex) {
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              // height: 65,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://urminstore.com/pub/media/catalog/product/cache/835e48150b5844ff4116c639e4c3d879/f/a/farali-tikha-front.jpg")),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                        fpricelist_Items[itemIndex]['Item_name'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 7, top: 5),
                                        child: Text(
                                          '\u{20B9} ${fpricelist_Items[itemIndex]['MRP']}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Flexible(
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(color: Colors.black,),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              //<-- SEE HERE
                                              borderSide: BorderSide(color: Colors.black,),
                                            ),
                                            filled: true,
                                           // fillColor: Colors.white,
                                          ),
                                         // dropdownColor: Colors.white,
                                          value: dropdownValue0,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue0 = newValue!;
                                            });
                                          },
                                          items: <String>['Carton', 'Unit']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(
                          keyboardType: TextInputType. number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                              ),
                                              enabledBorder: OutlineInputBorder(),
                                              labelText: 'Nos',
                                              hintText: 'Nos',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                            child: Text('Place Order',
                                style: TextStyle(fontSize: 20,color: Colors.white)),
                            onPressed: () {
                              showSummaryDialog();
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => afterCheckinMainPage(),));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kMainColor)),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showSummaryDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => OrderSummaryScreen(

        ));
  }
  Future<void> fshipmaster() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fshipmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Distributor_id": "dcbd62d4d5e6446634e5ba708be6e850"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {

        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

        //debugPrint("responseBody $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fshipmaster ${body}");
        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
  Future<void> fpricelist() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fpricelist/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "selector": {"Company_id":"1a36b22bdd89ffd361644e6ea06c2394"
        ,"Factory_id":"8101b2c0a710849dc04f61cc3c07cb9a","Price_id":
        "9d22b8a2af022745b593bf1c740ed329"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {

        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

       // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        debugPrint("responseBody fpricelist ${body['docs'][0]['item']}");
        fpricelist_Items=body['docs'][0]['item'];
        log("ItemCount "+fpricelist_Items.length.toString());

        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
  Future<void> fitemmaster() async {
    setState(() {
      idLoading =true;
    });

    // Replace with your actual API URL
    String apiUrl = 'http://api.urmingroup.co.in/fitemmaster/_find';

    // Replace with your actual authorization key
    String authorizationKey = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiJ9.cyGXfFZCzNNbY49K2LdTtbfGYSzGmoLYrSwfYWq-wEQ';

    // Replace with your actual request payload
    Map<String, dynamic> requestPayload = {
      "limit": 5000,
      "selector": {"Company_id": "1a36b22bdd89ffd361644e6ea06c2394", "Factory_id": "8101b2c0a710849dc04f61cc3c07cb9a"}
    };
    try {
      // Make the API call
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationKey',
        },
        body: json.encode(requestPayload),
      );
      setState(() {
        idLoading =false;
      });
      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          idLoading =false;
        });
        Map<String, dynamic> responseBody = json.decode(response.body);

       // debugPrint("responseBody  $responseBody");
        final body = jsonDecode(response.body);
        //body['docs'][0]['Item_name']
 ItemmasterData = body['docs'];
log(ItemmasterData.toString());
        for (int k = 0; k < ItemmasterData.length; k++) {
          for(int j=0; j<fpricelist_Items.length;j++){

          }
        //  debugPrint("responseBody fitemmaster ${body['docs'][k]['Status']}");
        }
        //fpricelist_Items=body['docs'][0]['item'];
        // var box = Hive.box('erpApiMainData');
        // box.put('erpApiMainData', body);
        // await Hive.openBox('erpApiMainData');
        // Map<String, dynamic>  bookmark=box.get('erpApiMainData');
        // bookmark.forEach((key, value) {
        //   PhoneVerification().launch(context);
        //   if(key=='bookmark')  {
        //     debugPrint("bookmark $value");
        //   }
        // });
      } else {
        setState(() {
          idLoading =false;
        });
        // Handle error
        print('API call failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      setState(() {
        idLoading =false;
      });
      // Handle any exceptions
      print('Error making API call: $error');
    }
  }
}
*/
