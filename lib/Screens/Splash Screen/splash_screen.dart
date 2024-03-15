// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../DMS_Screens/DMS_DashBoard.dart';
import '../../GlobalComponents/PreferenceManager.dart';
import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import '../Authentication/select_type.dart';
import '../Authentication/sign_in.dart';
import 'on_board.dart';

// ignore_for_file: library_private_types_in_public_api
class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? Login;

  @override
  void initState() {
    super.initState();
    PreferenceManager.instance.setStringValue(
        "ClintUrl", "https://dms.urmingroup.co.in/urminapi/");
    PreferenceManager.instance
        .getBooleanValue("Login")
        .then((value) => setState(() {
      Login=value;
      print(value);
      init();
    }));
  }

  Future<void> init() async {
    await Future.delayed( Duration(seconds: 2));
    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;

      Login!?Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Dms_HomeScreen()),
      ):Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SignIn()));
      // SignIn().launch(context);


  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
             Image(
              image: AssetImage('images/logo.png'),
              height: 150,
              width: 150,
            ),
            Text(
              'Urmin D.M.S/S.F.A',
              style: GoogleFonts.manrope(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
             Spacer(),
            Center(
              child: Padding(
                padding:  EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.manrope(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
