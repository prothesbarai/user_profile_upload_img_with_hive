import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> initHive() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.openBox("StoreUserImages");
  }
}