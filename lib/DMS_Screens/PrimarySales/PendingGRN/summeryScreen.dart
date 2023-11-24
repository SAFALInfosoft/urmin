// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../response/OrderDetailsItem.dart';
// import '../response/OrderDetailsListData.dart';
//
// class OrderSummaryScreen extends StatefulWidget {
//   final OrderDetailsListData data;
//   final String? routeName;
//   final Function(String) onSubmitCallBack;
//   final Function onCancelCallBack;
//
//   const OrderSummaryScreen(
//       {Key? key,
//         required this.data,
//         required this.routeName,
//         required this.onSubmitCallBack,
//         required this.onCancelCallBack})
//       : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<OrderSummaryScreen> {
//   String summary = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Order Summary'),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       elevation: 0.0,
//       actions: <Widget>[
//         const SizedBox(height: 20.0),
//         Row(
//           children: [
//             Flexible(
//               child: InkWell(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 2,
//                   padding: const EdgeInsets.all(5),
//                   decoration: const BoxDecoration(
//                       color: Color(0xFF555555),
//                       borderRadius: BorderRadius.all(Radius.circular(5))),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontFamily: 'poppins_regular'),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 onTap: () {
//                   widget.onCancelCallBack();
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Flexible(
//               child: InkWell(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 2,
//                   padding: const EdgeInsets.all(5),
//                   decoration: const BoxDecoration(
//                       color: Color(0XFF6883BC),
//                       borderRadius: BorderRadius.all(Radius.circular(5))),
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontFamily: 'poppins_regular'),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 onTap: () =>
//                 {widget.onSubmitCallBack(summary), Navigator.pop(context)},
//               ),
//             ),
//           ],
//         )
//       ],
//       content: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Container(
//           width: double.maxFinite,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const Divider(),
//               ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 0.4,
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Order ID        :",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 widget.data.orderNo.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Order date   :",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 widget.data.orderDate.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Shop Name  :",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 widget.data.party.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Party Name  :",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 widget.data.shopName.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Route Name  :",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Flexible(
//                                 child: Text(
//                                   widget.routeName.toString(),
//                                   overflow: TextOverflow.visible,
//
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Visibility(
//                             visible: false,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 5, bottom: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     "URN NO        :",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     widget.data.uRNNo.toString(),
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: widget.data != null
//                           ? buildOrderDueDataListing(context, widget.data)
//                           : Align(
//                         alignment: Alignment.center,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             SizedBox(
//                                 height: 100,
//                                 width: 100,
//                                 child: Image(
//                                     image: AssetImage(
//                                       'images/ic_app_icon.png',
//                                     ))),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               "Order item list not found",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: "poppins_regular",
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: 17.0),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total ',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                     Text(
//                       widget.data.grandTotal.toString(),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               TextFormField(
//                 autofocus: false,
//                 maxLines: 3,
//                 onChanged: (value) {
//                   summary = value;
//                   setState(() {});
//                 },
//                 inputFormatters: [
//                   FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),],
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                     color: Colors.black),
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     hintText: "Add Summary",
//
//                     hintStyle: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                         color: Colors.grey)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildOrderDueDataListing(
//       BuildContext context,
//       OrderDetailsListData data,
//       ) {
//     return ListView.builder(
//         physics: const ClampingScrollPhysics(),
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         itemCount: data.items != null ? data.items?.length : 0,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               elevation: 5,
//               margin:
//               const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
//               child: customMenuItem(data.items![index]));
//         });
//   }
//
//   Widget customMenuItem(OrderDetailsItem data) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               data.itemName.toString(),
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 14.0,
//               ),
//             ),
//           ),
//           // ignore: prefer_const_constructors
//           SizedBox(height: 3),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 'Quantity :',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 data.qty.toString(),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 3),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 'Rate :',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 data.rate.toString(),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 3),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const Text(
//                 'Amount :',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.0,
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 data.amount.toString(),
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14.0,
//                     color: Colors.black),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
