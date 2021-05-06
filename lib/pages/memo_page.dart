import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';

class MemoPage extends StatelessWidget {
  final Memo memo;
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
            Text(memo.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            ),
            Text(memo.detail,
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
