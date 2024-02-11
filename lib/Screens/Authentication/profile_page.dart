
import 'package:flutter/material.dart';
import 'package:maan_hrm/json/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constant.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _email =
      TextEditingController(text: "nakulparmar62@gmail.com");
  TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  TextEditingController password = TextEditingController(text: "9586096575");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding:  EdgeInsets.all(20.0),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
              color: kBgColor,
            ),
            child: Padding(
              padding:  EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:  [
                  //     Text(
                  //       "User Profile",
                  //       style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //           color: black),
                  //     ),
                  //    // Icon(AntDesign.setting)
                  //   ],
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      //leading: Image.asset('images/Pro.png'),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           SizedBox(
                            height: 20.0,
                          ),
                           CircleAvatar(
                            radius: 60.0,
                            backgroundColor: kMainColor,
                            backgroundImage: AssetImage(
                              'images/Pro.png',
                            ),
                          ),

                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          Text(
                            'Nakul Parmar',
                            style: kTextStyle.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: black),
                          ),
                          SizedBox(height: 20,),

                          Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            controller: _email,
                            cursorColor: black,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold, color: black),
                            decoration: InputDecoration(
                                hintText: "Email", border: InputBorder.none),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Mobile",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            obscureText: false,
                            controller: password,
                            cursorColor: black,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold, color: black),
                            decoration: InputDecoration(
                                hintText: "Password", border: InputBorder.none),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:  Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
