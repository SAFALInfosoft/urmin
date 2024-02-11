// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class ClientDetails extends StatefulWidget {
   ClientDetails({Key? key}) : super(key: key);

  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  String gender = 'Male';
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  DropdownButton<String> getGender() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String gender in genderList) {
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
            'Designer',
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
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                            dateController.text = date.toString().substring(0, 10);
                          },
                          controller: dateController,
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Icon(
                                Icons.date_range_rounded,
                                color: kGreyTextColor,
                              ),
                              labelText: 'Joining Date',
                              hintText: '11/09/2021'),
                        ),
                      ),
                       SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60.0,
                          child: FormField(
                            builder: (FormFieldState<dynamic> field) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelText: 'Select Gender',
                                    labelStyle: kTextStyle,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(child: getGender()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Contact Details',
                          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                         SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Email Address',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Phone Number',
                                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                         Divider(
                          thickness: 1.0,
                          color: kGreyTextColor,
                        ),
                         SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'support@maantheme.com',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '01764-432334',
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
