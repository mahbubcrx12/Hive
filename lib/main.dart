import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  var box = await Hive.openBox('mylist');
   //box.put("name","mahbub");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
