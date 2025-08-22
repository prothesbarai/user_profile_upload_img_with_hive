import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
class HiveService {
  static Future<void> initHive() async{
    /*
      if অংশ Web এর জন্য Hive initialize করা হচ্ছে। Web এ কোনো ফাইল সিস্টেম নেই, তাই Hive internally browser এর localStorage ব্যবহার করে ডেটা সংরক্ষণ করে।
      if অংশ শুধুমাত্র Web প্ল্যাটফর্মে execute হবে। .... else  অংশ অংশ Mobile এবং Desktop App এর জন্য  .. Without Web Only else
    */
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      await Hive.openBox("StoreUserImages");
    }
  }

}