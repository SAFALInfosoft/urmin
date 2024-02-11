import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/button_global.dart';
import 'package:maan_hrm/Screens/Salary%20Statement/salary_statement_list.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

// ignore_for_file: library_private_types_in_public_api
class addNewShop extends StatefulWidget {
   addNewShop({Key? key}) : super(key: key);

  @override
  _addNewShopState createState() => _addNewShopState();
}

class _addNewShopState extends State<addNewShop> {
  List<String> userChecked = [];
  String designation = 'Designer';
  String gender = 'Full Time';
  bool selection = false;
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  DropdownButton<String> getDesignation() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in designations) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: designation,
      onChanged: (value) {
        setState(() {
          designation = value!;
        });
      },
    );
  }

  DropdownButton<String> getGender() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in employeeType) {
      var item = DropdownMenuItem(
        value: gender,
        child: Text(gender),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: gender,
      onChanged: (value) {
        setState(() {
          gender = value!;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: Text(
          'Add New Shop',
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.height(),
          padding:  EdgeInsets.all(20.0),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
               SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                ),
                child: ListTile(
                  leading: Image.asset('images/Pro.png'),
                  title: Text(
                    'Name: Nakul Parmar',
                    style: kTextStyle.copyWith(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Route: Bopal-Ambli Road',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 20.0,
              ),
              AppTextField(
                textFieldType: TextFieldType.USERNAME,
                decoration:  InputDecoration(
                  labelText: 'Shop Name',
                  hintText: 'Shop Name',
                  border: OutlineInputBorder(),
                ),
              ),
               SizedBox(
                height: 20.0,
              ),
              AppTextField(
                textFieldType: TextFieldType.PHONE,
                decoration:  InputDecoration(
                  labelText: 'Owner Name',
                  hintText: 'Shop Address',
                  border: OutlineInputBorder(),
                ),
              ), SizedBox(
                height: 20.0,
              ),
              AppTextField(
                textFieldType: TextFieldType.PHONE,
                decoration:  InputDecoration(
                  labelText: 'Address',
                  hintText: 'Shop Address',
                  border: OutlineInputBorder(),
                ),
              ),
               SizedBox(
                height: 20.0,
              ),
              AppTextField(
                textFieldType: TextFieldType.PHONE,
                decoration:  InputDecoration(
                  labelText: 'Mobile number',
                  hintText: '+91 00000 00000',
                  border: OutlineInputBorder(),
                ),
              ),
               SizedBox(
                height: 20.0,
              ),
              AppTextField(
                textFieldType: TextFieldType.PHONE,
                decoration:  InputDecoration(
                  labelText: 'Tax Number',
                  hintText: '1234567890',
                  border: OutlineInputBorder(),
                ),
              ),
               SizedBox(
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
                    border:  OutlineInputBorder(),
                  ),
                ),
              ),
               SizedBox(
                height: 20.0,
              ),
              ButtonGlobal(
                buttontext: 'Add Shop',
                buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                onPressed: () {
                   SalaryStatementList().launch(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
