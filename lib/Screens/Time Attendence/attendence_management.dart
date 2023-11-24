import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constant.dart';

// ignore_for_file: library_private_types_in_public_api
class AttendanceManagement extends StatefulWidget {
  const AttendanceManagement({Key? key}) : super(key: key);

  @override
  _AttendanceManagementState createState() => _AttendanceManagementState();
}

class _AttendanceManagementState extends State<AttendanceManagement> {
  bool isApproved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Employee Attend List',
          maxLines: 2,
          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Image(
            image: AssetImage('images/employeesearch.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                color: kBgColor,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isApproved = !isApproved;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: !isApproved ? kMainColor : kMainColor.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(
                                'Request (4)',
                                style: kTextStyle.copyWith(color: !isApproved ? Colors.white : kTitleColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isApproved = !isApproved;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: isApproved ? kMainColor : kMainColor.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(
                                'Approved',
                                style: kTextStyle.copyWith(color: isApproved ? Colors.white : kTitleColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // const EmployeeDetails().launch(context);
                          },
                          leading: Image.asset('images/emp1.png'),
                          title: Text(
                            'Sahidul islam',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'Designer',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          trailing: Container(
                            height: 50.0,
                            width: 80.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kMainColor.withOpacity(0.08),
                            ),
                            child: Center(
                              child: Text(
                                'P',
                                style: kTextStyle.copyWith(color: kMainColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'In Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Out Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.0,
                              color: kGreyTextColor,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '10-06-2021',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '09:00 AM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '05:00 PM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: !isApproved,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kMainColor,
                                ),
                                child: Text(
                                  'Approve',
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kAlertColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Reject',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isApproved,
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 3.0,
                            progressColor: kAlertColor,
                            percent: 0.68,
                            animation: true,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('7h 25m 42s', style: kTextStyle.copyWith(fontSize: 12.0)),
                                Text('of 9 Hours', style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // const EmployeeDetails().launch(context);
                          },
                          leading: Image.asset('images/emp2.png'),
                          title: Text(
                            'Ibne Read',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'Developer',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          trailing: Container(
                            height: 50.0,
                            width: 80.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kAlertColor.withOpacity(0.08),
                            ),
                            child: Center(
                              child: Text(
                                'A',
                                style: kTextStyle.copyWith(color: kAlertColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'In Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Out Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.0,
                              color: kGreyTextColor,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '10-06-2021',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '09:00 AM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '05:00 PM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: !isApproved,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kMainColor,
                                ),
                                child: Text(
                                  'Approve',
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kAlertColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Reject',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isApproved,
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 3.0,
                            progressColor: kAlertColor,
                            percent: 0.00,
                            animation: true,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('0h 0m 0s', style: kTextStyle.copyWith(fontSize: 12.0)),
                                Text('of 9 Hours', style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // const EmployeeDetails().launch(context);
                          },
                          leading: Image.asset('images/emp3.png'),
                          title: Text(
                            'Mehedi Mohammad',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'Manager',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          trailing: Container(
                            height: 50.0,
                            width: 80.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kHalfDay.withOpacity(0.08),
                            ),
                            child: Center(
                              child: Text(
                                'H/D',
                                style: kTextStyle.copyWith(color: kHalfDay, fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'In Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Out Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.0,
                              color: kGreyTextColor,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '10-06-2021',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '09:00 AM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '05:00 PM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: !isApproved,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kMainColor,
                                ),
                                child: Text(
                                  'Approve',
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kAlertColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Reject',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isApproved,
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 3.0,
                            progressColor: kAlertColor,
                            percent: 0.45,
                            animation: true,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('4h 25m 42s', style: kTextStyle.copyWith(fontSize: 12.0)),
                                Text('of 9 Hours', style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // const EmployeeDetails().launch(context);
                          },
                          leading: Image.asset('images/emp4.png'),
                          title: Text(
                            'Emily Jones',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'Designer',
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          trailing: Container(
                            height: 50.0,
                            width: 80.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kGreenColor.withOpacity(0.08),
                            ),
                            child: Center(
                              child: Text(
                                'H',
                                style: kTextStyle.copyWith(color: kGreenColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'In Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Out Time',
                                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.0,
                              color: kGreyTextColor,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '10-06-2021',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '09:00 AM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '05:00 PM',
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Visibility(
                          visible: !isApproved,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kMainColor,
                                ),
                                child: Text(
                                  'Approve',
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: kAlertColor.withOpacity(0.1),
                                ),
                                child: Text(
                                  'Reject',
                                  style: kTextStyle.copyWith(
                                    color: kAlertColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isApproved,
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 3.0,
                            progressColor: kAlertColor,
                            percent: 0.00,
                            animation: true,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('0h 0m 0s', style: kTextStyle.copyWith(fontSize: 12.0)),
                                Text('of 9 Hours', style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
