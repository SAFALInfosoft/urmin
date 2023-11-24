import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constant.dart';

const Color avtar_backGround = Color(0xFF2FCB72);
const Color avtar_backGround1 = Color(0xFF0C3329);
const Color prof_Card = Color(0xFF196F3D);
const Color grade1 = Color(0xFF00b09b);
const Color grade2 = Color(0xFF96c93d);
const Color cool = Color(0xFF181A2F);
const clickedColor = Color(0xFF0C3329);
const unclickedColor = Color(0xFF196F3D);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFFE7E7E7);
Color bronze = Color(0xFFA45735);

//Color list_item = Colors.grey[200];

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<String> names = [
    "Nakul Parmar",
    "Dev Gavli",
    "Aryan Varma",
    "Nikuj Rohit",
    "Sagar Bhavsar",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4"
  ];
  List<String> litems = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: Image.asset('images/Pro.png'),
            title: Text(
              "Sagar Bhavsar",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              "#5",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            trailing: Text(
              "2500",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      )),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: probtn,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 180.0,
            // bottom: PreferredSize(
            //   preferredSize: Size.fromHeight(4.0),
            //   child: Container(
            //     color: avtar_backGround1,
            //     height: 50,
            //     child: Container(
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           //SizedBox(width: 35),
            //           Text("Postion",
            //               style: TextStyle(
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.bold)),
            //           //SizedBox(width: 52),
            //           Text(
            //             "Profile",
            //             style:
            //             TextStyle(
            //                 color: Colors.grey[200],
            //                 fontWeight: FontWeight.bold),
            //           ),
            //          // SizedBox(width: 60),
            //
            //           Text(
            //             "Name",
            //             style:
            //             TextStyle(
            //                 color: Colors.grey[200],
            //                 fontWeight: FontWeight.bold),
            //           ),
            //          // SizedBox(width: 60),
            //
            //           Text(
            //             "Score",
            //             style: TextStyle(
            //                 color: Colors.grey[200],
            //                 fontWeight: FontWeight.bold),
            //           )
            //         ],
            //       ),),),),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "LEADERBOARD",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.emoji_events_rounded,
                      color: gold,
                      size: 70,
                    ),
                  ],
                ),
              ),
            ),
            elevation: 9.0,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => buildList(context, index),
            childCount: 5,
          ))
        ],
      ),
    );
  }

  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];

    Widget listItem;
    if (ind == 1) {
      listItem = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: gold,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: Image.asset('images/Pro.png'),
            title: Text(
              name,
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              "#$pos",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            trailing: Text(
              "2500 👑",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    } else if (ind == 2) {
      listItem = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: silver,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: Image.asset('images/Pro.png'),
            title: Text(
              name,
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              "#$pos",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            trailing: Text(
              "2500",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    } else if (ind == 3) {
      listItem = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: bronze,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: Image.asset('images/Pro.png'),
            title: Text(
              name,
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              "#$pos",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            trailing: Text(
              "2500",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    } else {
      listItem = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: Image.asset('images/Pro.png'),
            title: Text(
              name,
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              "#$pos",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
            trailing: Text(
              "2500",
              style: kTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: listItem,
        ),
      ],
    );
  }
}
