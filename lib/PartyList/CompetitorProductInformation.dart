// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';
import '../GlobalComponents/button_global.dart';
import 'afterCheckinMainPage.dart';

class CompetitorProductInformation extends StatefulWidget {
   CompetitorProductInformation({Key? key}) : super(key: key);

  @override
  _CompetitorProductInformationState createState() => _CompetitorProductInformationState();
}

class _CompetitorProductInformationState extends State<CompetitorProductInformation> {
  @override
  Widget build(BuildContext context) {
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
            'Competitor Product Information',
            maxLines: 2,
            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      decoration:  InputDecoration(
                        labelText: 'Brand Name',
                        // hintText: '543223',
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      decoration:  InputDecoration(
                        labelText: 'Item Name',
                        // hintText: '543223',
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
                          labelText: 'Click Images',
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
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      decoration:  InputDecoration(
                        labelText: 'Remarks',
                        // hintText: '543223',
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.0,
                    ),
                    ButtonGlobal(
                      buttontext: 'Save',
                      buttonDecoration:
                      kButtonDecoration.copyWith(color: kMainColor),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => afterCheckinMainPage(),));

                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
