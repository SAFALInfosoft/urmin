import 'package:hive/hive.dart';
part 'po_offline_json.g.dart';

@HiveType(typeId: 7)
class POOfflineJson extends HiveObject {
  @HiveField(0)
  final String poJsonData;
  
  POOfflineJson(this.poJsonData, );

  @override
  String toString() {
    return poJsonData;
  }
}