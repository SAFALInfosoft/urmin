// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/credit_card_widget.dart';
// import 'package:maan_hrm/GlobalComponents/button_global.dart';
// import 'package:maan_hrm/Screens/Home/SFA_DashBoard.dart';
// import 'package:nb_utils/nb_utils.dart';
// import '../../constant.dart';
//
// // ignore_for_file: library_private_types_in_public_api
// class PaymentScreen extends StatefulWidget {
//    PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   String cardNumber = '4591 8432 3234 2123';
//   String expiryDate = '11/30';
//   String cardHolderName = 'Add Card';
//   String cvvCode = '000';
//   bool isCvvFocused = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: kMainColor,
//       appBar: AppBar(
//         backgroundColor: kMainColor,
//         elevation: 0.0,
//         titleSpacing: 0.0,
//         iconTheme:  IconThemeData(color: Colors.white),
//         title: Text(
//           'Payment',
//           maxLines: 2,
//           style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              SizedBox(
//               height: 20.0,
//             ),
//             Container(
//               height: context.height(),
//               width: context.width(),
//               padding:  EdgeInsets.all(20.0),
//               decoration:  BoxDecoration(
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 children: [
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   CreditCardWidget(
//                     textStyle: kTextStyle.copyWith(fontSize: 10.0, color: Colors.white),
//                     cardNumber: cardNumber,
//                     expiryDate: expiryDate,
//                     cardHolderName: cardHolderName,
//                     cvvCode: cvvCode,
//                     showBackView: isCvvFocused,
//                     obscureCardNumber: true,
//                     obscureCardCvv: true,
//                     isHolderNameVisible: true,
//                     cardBgColor: kMainColor,
//                     isSwipeGestureEnabled: true,
//                     onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
//                   ),
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Amount Section',
//                         style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   AppTextField(
//                     textFieldType: TextFieldType.NAME,
//                     decoration:  InputDecoration(
//                       labelText: 'Name',
//                       hintText: 'MaanTeam',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   AppTextField(
//                     textFieldType: TextFieldType.PHONE,
//                     decoration:  InputDecoration(
//                       labelText: 'Amount',
//                       hintText: '\$1000',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   AppTextField(
//                     textFieldType: TextFieldType.NAME,
//                     decoration:  InputDecoration(
//                       labelText: 'CardHolder name',
//                       hintText: 'MaanTeam',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                    SizedBox(
//                     height: 20.0,
//                   ),
//                   ButtonGlobal(
//                     buttontext: 'Pay Now',
//                     buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
//                     onPressed: () => showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Dialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             // ignore: sized_box_for_whitespace
//                             child: SizedBox(
//                               height: 400.0,
//                               child: Column(
//                                 children: [
//                                    SizedBox(
//                                     height: 20.0,
//                                   ),
//                                    Image(
//                                     image: AssetImage('images/paymentsuccess.png'),
//                                   ),
//                                    SizedBox(
//                                     height: 5.0,
//                                   ),
//                                   Text(
//                                     'Great',
//                                     style: kTextStyle.copyWith(color: kMainColor),
//                                   ),
//                                    SizedBox(
//                                     height: 5.0,
//                                   ),
//                                   Text(
//                                     'Payment Successful',
//                                     style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
//                                   ),
//                                    SizedBox(
//                                     height: 50.0,
//                                   ),
//                                   ButtonGlobal(
//                                       buttontext: 'Back To Home',
//                                       buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
//                                       onPressed: () {
//                                          HomeScreen().launch(context);
//                                       }),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
