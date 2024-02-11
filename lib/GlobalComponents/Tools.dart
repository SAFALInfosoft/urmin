import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Tools {
  BuildContext context;
  StreamSubscription? connection;

  Tools(this.context);

  String capitalizeOnlyFirstLater(String string) {
    if (string.trim().isEmpty) return "";
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }

  void ShowDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
         CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        Container(
            margin:  EdgeInsets.only(left: 10),
            child:  Text("Loading...")),
      ]),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.transparent,
        content: Row(mainAxisSize: MainAxisSize.min, children: [
          Center(
              child: Container(
            margin:  EdgeInsets.all(50),
            child: Lottie.asset(
              'images/loading.json',
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ))
        ]));

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void stopLoading() {
    Navigator.of(context).pop();
  }

  bool isValidMobileNo(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isValidMobileNumber(String value) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';

    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  bool isValidDomain(String email) {
    String p =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  String getBase64FormatFile(String path) {
    File file = File(path);
    debugPrint('File is = ' + file.toString());
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  bool checkInternetConnection() {
    bool isOffline = true;
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        isOffline = true;
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        isOffline = false;
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        isOffline = false;
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        isOffline = false;
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        isOffline = false;
      }
    });
    return isOffline;
  }

  void logInfo(String msg, int type) {
    if (type == 1) {
      developer.log('\x1B[34m$msg\x1B[0m');
    } else if (type == 2) {
      developer.log('\x1B[31m$msg\x1B[0m');
    } else if (type == 3) {
      developer.log('\x1B[33m$msg\x1B[0m');
    }
  }
}
