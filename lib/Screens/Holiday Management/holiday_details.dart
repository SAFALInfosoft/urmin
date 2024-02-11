import 'package:flutter/material.dart';
import 'package:maan_hrm/GlobalComponents/product_data.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

// ignore_for_file: library_private_types_in_public_api
class HolidayDetails extends StatefulWidget {
   HolidayDetails({Key? key}) : super(key: key);

  @override
  _HolidayDetailsState createState() => _HolidayDetailsState();
}

class _HolidayDetailsState extends State<HolidayDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        iconTheme:  IconThemeData(color: Colors.white),
        title: ListTile(
          leading: Image.asset('images/emp1.png'),
          title: Text(
            'Sahidul Islam',
            style: kTextStyle.copyWith(color: Colors.white),
          ),
          subtitle: Text(
            '11-9-2021',
            style: kTextStyle.copyWith(color: Colors.white),
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding:  EdgeInsets.all(20.0),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: kBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding:  EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: kTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          description,
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                   Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60.0,
                          padding:  EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: kMainColor,
                          ),
                          child: Center(
                              child: Text(
                            'Delete',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                       SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 60.0,
                          padding:  EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kMainColor.withOpacity(0.1),
                          ),
                          child: Center(
                              child: Text(
                            'Edit',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
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
