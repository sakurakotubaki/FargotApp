import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FargotPassword extends StatefulWidget {
  const FargotPassword({Key? key}) : super(key: key);

  @override
  State<FargotPassword> createState() => _FargotPasswordState();
}

class _FargotPasswordState extends State<FargotPassword> {
  // 入力したメールアドレス・パスワード
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワードの再登録'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力用テキストフィールド
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'メールアドレスを入力してください'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              // パスワードリセット登録ボタン
              ElevatedButton(
                  child: const Text('パスワードリセットする'),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _email);
                      print("パスワードリセット用のメールを送信しました");
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
