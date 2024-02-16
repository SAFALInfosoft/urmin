import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maan_hrm/Screens/Splash%20Screen/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'RESPONSE/Item.dart';
import 'RESPONSE/Itemlistresponse.dart';
import 'RESPONSE/erpApiMainDataResponse.dart';
import 'RESPONSE/fshipmasterResponse.dart';
import 'RESPONSE/poListRespose.dart';
import 'RESPONSE/po_offline_json.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
 Hive.registerAdapter(ErpApiMainDataResponseAdapter());
  await Hive.openBox('erpApiMainData');
  Hive.registerAdapter(fshipmasterResponseAdapter());
  await Hive.openBox('fshipmasterData');
  Hive.registerAdapter(NamkeenItemAdapter());
  await Hive.openBox('ItemList');
  Hive.registerAdapter(PurchaseOrderAdapter());
  await Hive.openBox('poList');
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox('added_itemjsonData');
  Hive.registerAdapter(POOfflineJsonAdapter());
  await Hive.openBox('PO_OfflineJson');
  //Hive.registerAdapter(ErpApiMainDataResponse(docs: [], bookmark: '', warning: '') as TypeAdapter);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // Add the line below to get horizontal sliding transitions for routes.
        pageTransitionsTheme:  PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      title: 'Urmin',
      home:  SplashScreen(),
    );
  }
}
