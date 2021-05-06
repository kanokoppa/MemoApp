import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';

class MemoPage extends StatelessWidget {
  final QueryDocumentSnapshot memo;
  MemoPage(this.memo);
  //このページに遷移するときにMemo型の値を送ってくるように

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('確認画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(memo.data()['title'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            ),
            Text(memo.data()['detail'],
            style: TextStyle(
              fontSize: 18
            ),
            ),
          ],
        ),
      ),

    );
  }
}
