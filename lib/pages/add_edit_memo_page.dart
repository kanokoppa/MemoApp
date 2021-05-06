import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEdiMemoPage extends StatefulWidget {
  final QueryDocumentSnapshot memo;
  //QueryDocumentSnapshot型のmemoを定義
  AddEdiMemoPage({this.memo});
  //AddEditMemoPageにくるタイミングでmemoに対して値を送る
  @override
  _AddEdiMemoPageState createState() => _AddEdiMemoPageState();
}

class _AddEdiMemoPageState extends State<AddEdiMemoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> addMemo() async{
    var collection = FirebaseFirestore.instance.collection('memo');
    //memoというコレクションの中にドキュメントを追加したいので、まずはmemoというcollectionを取得する。collectionという変数を定義。
    collection.add({
      'title': titleController.text,
      //titleというフィールドに入力された情報titleControllerをいれることでタイトル欄に入力された文字を取得することができる
      'detail': detailController.text,
      'created_date':Timestamp.now(),
    });
  }

  Future<void> updateMemo() async{
  var document = FirebaseFirestore.instance.collection('memo').doc(widget.memo.id);
  //どのドキュメントを編集するか指定
    document.update({
      'title': titleController.text,
      'detail': detailController.text,
      'update_time': Timestamp.now(),
    });

  }



  @override
  void initState() {
    super.initState();
    if(widget.memo != null){
      titleController.text = widget.memo.data()['title'];
      detailController.text = widget.memo.data()['detail'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null? 'メモを追加' : 'メモを編集'),
      ),
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:40),
              child: Text(
                'タイトル',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  //画面幅の８割
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 10
                      )
                    ),
                    //下の下線が消える
                  )),
            ),

            Padding(
              padding: const EdgeInsets.only(top:40),
              child: Text(
                'メモ内容',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  //画面幅の８割
                  child: TextField(
                    controller: detailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 10
                        )
                    ),
                    //下の下線が消える
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text(widget.memo == null ? '追加' : '編集'),
                    onPressed: () async{
                    if(widget.memo == null) {
                      await addMemo();
                    } else
                    await updateMemo();
                    Navigator.pop(context);
                    },
                    //addMemoがめっちゃ時間かかったとしてもaddMemoが終わるまでNavigator.popできないようにしておく。
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
