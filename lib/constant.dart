import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 Color kMainColor = Color(0xFF2957a4);
Color kGreyTextColor = Color(0xFF9090AD);
Color kBorderColorTextField = Color(0xFFC2C2C2);
Color kDarkWhite = Color(0xFFF1F7F7);
Color kTitleColor = Color(0xFF22215B);
Color kAlertColor = Color(0xFFFF8919);
Color kBgColor = Color(0xFFFAFAFA);
Color  kHalfDay = Color(0xFFE8B500);
Color  kGreenColor = Color(0xFF08BC85);

final kTextStyle = GoogleFonts.manrope(
  color: kTitleColor,
);
String purchaseCode = '528cdb9a-5d37-4292-a2b5-b792d5eca03a';
 BoxDecoration kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(5),
  ),
);

 InputDecoration kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: kMainColor.withOpacity(0.1)),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding:  EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

List<String> employees = [
  '0 - 10',
  '11 - 20',
  '21 - 30',
  '31 - 40',
  '41 - 50',
  '51 - 60',
  '61 - 70',
  '71 - 80',
  '81 - 90',
  '91 - 100',
];
List<String> Compney = [
 'Urmin'
];List<String> Language = [
 'English','Hindi','Gujarati'
];
List<String> designations = ['Designer', 'Manager', 'Developer', 'Officer'];

List<String> employeeType = [
  'Full Time',
  'Part Time',
  'Freelance',
  'Remote',
];

List<String> employeeName = ['Sahidul Islam', 'Ibne Riead', 'Mehedi Muhammad', 'Emily Jones'];

List<String> ExpanseType = ['Ticket', 'Private', 'Mobile Recharge', 'PhotoCopy','Courier','Local Convenience','Daily Allowance','Stationery'];

List<String> genderList = ['Male', 'Female'];

List<String> expensePurpose = [
  'Privilege Leave (PL)',
  'Casual Leave (CL)',
  'Sick Leave (SL)',
  'Maternity Leave (ML)',
  'Compensatory Off (Comp-off)',
  'Marriage Leave',
  'Paternity Leave',
  'Bereavement Leave',
  'Loss of Pay (LOP) / Leave Without Pay (LWP)',
];List<String> paymentModes = [
  'Address',

];
List<String> posStats = [
  'Daily',
  'Monthly',
  'Yearly',
];
List<String> saleStats = [
  'Weekly',
  'Monthly',
  'Yearly',
];
