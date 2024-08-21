import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'home.dart';
//?
Box? mybox;

Future<Box> openHiveBox(dynamic boxname) async {
  if (!Hive.isBoxOpen(boxname)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxname);
}
//?
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تهيئة Flutter للتأكد من أن كل شيء جاهز قبل البدء
  mybox = await openHiveBox("cat"); // فتح صندوق Hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
