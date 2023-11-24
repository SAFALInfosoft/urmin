import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maan_hrm/constant.dart';
import 'package:maan_hrm/viewOrder.dart';
import 'package:nb_utils/nb_utils.dart';
class viewOrders extends StatefulWidget {
  const viewOrders({Key? key}) : super(key: key);

  @override
  State<viewOrders> createState() => _viewOrdersState();
}

class _viewOrdersState extends State<viewOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'Order List',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.height(),
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  //controller: controller,
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  autocorrect: true,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Material(
                          elevation: 2.0,
                          child: Container(
                            width: context.width(),
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFF4DCEFA),
                                  width: 3.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              onTap: () {

                              },
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order No: OA-1234',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Shop: Abc Shop',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ),  Text(
                                    'Party: Nakul Parmar',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Address: Address',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Total Qty: 10',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Total Amount: ₹999.0',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ), Text(
                                    '25/10/2023',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    OrderDetailsPage().launch(context);
                                  },
                                  child: Text("Order Details >>",style: TextStyle(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),);
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
