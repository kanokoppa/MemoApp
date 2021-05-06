import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/pages/add_memo_page.dart';
import 'package:memo_app/pages/memo_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  CollectionReference memos;
  //CollectionReference型のmemos変数を定義


  @override
  initState()  {
    super.initState();
    memos = FirebaseFirestore.instance.collection('memo');

    //memosの中にmemoコレクションの内容を入れる
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase×Flutter'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: memos.snapshots(),
        //memoコレクションに値が入ったり変化が加えられるとstreamが反応してbuilderが動く
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data.docs[index].data()['title']),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                    showModalBottomSheet(context: context, builder: (context){

                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              trailing: Icon(Icons.edit,color: Colors.lightBlueAccent,),
                              title: Text('編集'),
                              onTap: (){
                              },
                            ),
                            ListTile(
                              trailing: Icon(Icons.delete, color: Colors.redAccent,),
                              title: Text('削除'),
                              onTap: (){
                              },
                            ),
                          ],
                        ),
                      );
                    });
                },
                  ),
                  onTap: (){
                    //確認画面に遷移
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(snapshot.data.docs[index])));
                  },
                );
              }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemoPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
