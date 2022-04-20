import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_shared_prefs_db/models/products.dart';
import 'package:tugas_shared_prefs_db/home/home_page.dart';
import 'package:tugas_shared_prefs_db/models/boxes.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(ProductsAdapter());
  await Hive.openBox<Products>(HiveBox.products);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
