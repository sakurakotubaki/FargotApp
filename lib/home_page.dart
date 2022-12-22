import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appbarの戻るボタン消す
        automaticallyImplyLeading: false,
        title: Text('ログインしました!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // ログアウト処理
              // 内部で保持しているログイン情報等が初期化される
              await FirebaseAuth.instance.signOut();
              print('Logout');
            },
          ),
        ],
      ),
      body: Center(
        // ユーザー情報を表示
        child: Text('ようこそ!'),
      ),
    );
  }
}
