import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/PartyList/afterCheckinMainPage.dart';
import 'package:maan_hrm/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../RouteManagement/addNewShop.dart';

class MyPartyList extends StatefulWidget {
   MyPartyList({Key? key}) : super(key: key);

  @override
  State<MyPartyList> createState() => _MyPartyListState();
}

class _MyPartyListState extends State<MyPartyList> {
  int finalIndex=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'Party List',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.height(),
          padding:  EdgeInsets.all(20.0),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: CupertinoSearchTextField(
                        //controller: controller,
                        onChanged: (value) {},
                        onSubmitted: (value) {},
                        autocorrect: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: SizedBox(
                      // width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          setState(() {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => addNewShop(),));
                          });
                        },
                        //icon:  Icon(Icons.home_filled),
                        child:  Text(
                          "Add Shop",
                          style: TextStyle(
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics:  ClampingScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    //log(-index);
                    return Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Material(
                              elevation: 2.0,
                              child: Container(
                                width: context.width(),
                                padding:  EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Color(0xFF4DCEFA),
                                      width: 3.0,
                                    ),
                                  ),
                                  color: index == 1
                                      ? Colors.white
                                      : Colors.white),
                                child: ListTile(
                                  onTap: () {},
                                  leading:  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'images/employeemanagement.png'),
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shop: Abc Shop',
                                        maxLines: 2,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Party: Nakul Parmar',
                                        maxLines: 2,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Mobile: +91 9586096575',
                                        maxLines: 2,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Address: Address',
                                        maxLines: 2,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  trailing:
                                      CircleAvatar(child: Icon(Icons.call)),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: finalIndex==index ? true : false,
                              child: Material(
                                elevation: 2.0,
                                child: Container(
                                  width: context.width(),
                                  padding:  EdgeInsets.all(10.0),
                                  decoration:  BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xFF4DCEFA),
                                        width: 3.0,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:  EdgeInsets.all(5.0),
                                          child: SizedBox(
                                            // width: MediaQuery.of(context).size.width / 3,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  Colors.green),
                                              onPressed: () {
                                                setState(() {});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          afterCheckinMainPage(),
                                                    ));
                                              },
                                              icon:  Icon(CupertinoIcons.check_mark_circled_solid),
                                              label:  Text(
                                                "Check In",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.all(5.0),
                                        child: SizedBox(
                                          // width: MediaQuery.of(context).size.width / 3,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue),
                                            onPressed: () {
                                              setState(() {});
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        afterCheckinMainPage(),
                                                  ));
                                            },
                                            child:  Icon(Icons.location_on),
                                            // label:  Text(
                                            //   "Get Direction",
                                            //   style: TextStyle(
                                            //       color: Colors.white),
                                            // ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.all(5.0),
                                        child: SizedBox(
                                          // width: MediaQuery.of(context).size.width / 3,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              setState(() {});
                                              finalIndex =index+1;
                                            },
                                            child:  Icon(CupertinoIcons.clear_circled_solid),
                                            // label:  Text(
                                            //   "Shop Close",
                                            //   style: TextStyle(
                                            //       color: Colors.white),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
