// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:maan_hrm/Screens/Authentication/edit_profile.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../GlobalComponents/PreferenceManager.dart';
import '../../constant.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? distributorName;

  String? Company_Name;

  String? Mobile_no;
 String? Email_id;


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      openHiveBox();
    });
    PreferenceManager.instance
        .getStringValue("distributorName")
        .then((value) => setState(() {
      distributorName=value;
      print("distributorName"+value);
    }));PreferenceManager.instance
        .getStringValue("Company_Name")
        .then((value) => setState(() {
      Company_Name=value;
      print("Company_Name"+value);
    }));
    super.initState();
  }
  openHiveBox() async {
    var box = await Hive.openBox('erpApiMainData');
    var bookmark = box.get('erpApiMainData');
    bookmark.forEach((key, value) {
      log(key.toString());
      if (key == 'docs') {
        debugPrint("erpApiMainData  ${value[0]}");
        setState(() {
          log("TCS"+value[0]['TCS_Applicable']);
          Company_Name=value[0]['Company_Name'];
          Mobile_no=value[0]['Mobile_no'];
          Email_id=value[0]['Email_id'];

        });
      }
    });
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
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //    Padding(
        //      padding: const EdgeInsets.only(right: 10.0),
        //      child: Icon(
        //      Icons.edit   ).onTap(() {
        //      //  EditProfile().launch(context);
        //      }),
        //    ),
        // ],
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(
                      height: 5.0,
                    ),
                     CircleAvatar(
                      radius: 60.0,
                      backgroundColor: kMainColor,
                      backgroundImage: AssetImage(
                        'images/Pro.png',
                      ),
                    ),
                     SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${distributorName ?? ""}',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 17),
                    ),
                     SizedBox(
                      height: 10.0,
                    ),
                    Divider(),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      readOnly: true,
                      textFieldType: TextFieldType.NAME,
                      decoration:  InputDecoration(
                        labelText: 'Distributor Name',
                        hintText: '${distributorName ?? ""}',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      readOnly: true,
                      textFieldType: TextFieldType.NAME,
                      decoration:  InputDecoration(
                        labelText: 'Company_Name',
                        hintText: '${Company_Name ?? ""}',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      readOnly: true,
                      textFieldType: TextFieldType.EMAIL,
                      decoration:  InputDecoration(
                        labelText: 'Email Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: Email_id??"",
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: TextEditingController(),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: Mobile_no??"",
                        labelStyle: kTextStyle,
                        border:  OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      readOnly: true,
                      textFieldType: TextFieldType.ADDRESS,
                      decoration:  InputDecoration(
                        labelText: 'Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
