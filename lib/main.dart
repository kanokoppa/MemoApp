import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/pages/top_page.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//initializedAppをした後にMyAppをして欲しいのでasync awaitを使うがmain関数のなかで直接使うことはできないのでWidgetsFlutterBinding.ensureInitialized();を使う

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopPage(title: 'Flutter '),
    );
  }
}

