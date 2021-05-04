import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Memo> memoList = [];

  Future<Void> getMemo() async {
    //情報を取ってくるメソッド
    var snapshot = await FirebaseFirestore.instance.collection('memo').get();
    //コレクション名をmemoという名で登録していたのでmemo↑
    //getの処理が時間かかるのでawait
    var docs = snapshot.docs;
    //docsはドキュメントの名前の部分
    docs.forEach((doc) {
      //docが一個一個のドキュメント
      memoList.add(Memo(
          title: doc.data()['title'],
          detail: doc.data()['detail']));
    });

    setState(() {
      //画面再描画
    });
  }

  @override
  initState() {
    super.initState();
    getMemo();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase×Flutter'),
      ),
      body: ListView.builder(
          itemCount: memoList.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(memoList[index].title),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
