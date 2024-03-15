import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maan_hrm/DMS_Screens/PrimarySales/PO/pendingPO.dart';
import 'package:maan_hrm/DMS_Screens/PrimarySales/PO/purchaseOrderMainScreen.dart';
import 'package:maan_hrm/constant.dart';

import '../PRIMARY_SALES_MENU.dart';
import 'DraftPO.dart';

class po_Tab_View extends StatefulWidget {
  @override
  _po_Tab_ViewState createState() => _po_Tab_ViewState();
}

class _po_Tab_ViewState extends State<po_Tab_View>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    CheckUserConnection().then((value) {
      if (ActiveConnection == true) {
      } else {
        kMainColor = Colors.red;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          kMainColor = Color(0xFF2957a4);
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {

        ActiveConnection = false;
        kMainColor = Colors.red;
        T = "Turn On the data and repress again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CheckUserConnection();
    return WillPopScope(
      onWillPop: ()async{
        return await Navigator.push(context,  MaterialPageRoute(builder: (context) =>
            PRIMARY_SALES_MENU()));
      },
      child: Scaffold(
        backgroundColor: kMainColor,
        appBar: AppBar(
          backgroundColor: kMainColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Purchase Order',
            maxLines: 2,
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            ActiveConnection
                ? Container()
                : Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Image(
                color: Colors.white,
                height: 30,
                width: 30,
                image: AssetImage('images/wifi.png'),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              TabBar(
                controller: _tabController,
                //automaticIndicatorColorAdjustment: true,
                // give the indicator a decoration (color and border radius)
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black38,
                tabs: const [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Pending PO',
                  ),
                  Tab(
                    text: 'Draft PO',
                  ),
                  //second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Web PO',
                  ),
                ],
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    pendingPO() ,
                    DraftPO(),
                    purchaseOrderMainScreen()
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}