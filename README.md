# パスワードリセットのDemoアプリ

- アプリの用件
  - FirebaseAuthenticationで認証機能のDemoアプリを作成
    - Version1は通常の画面遷移する
    - Version2はgo_router: ^5.2.4で画面遷移する
    - go_router6.0.0は不具合あるそうなので使用しませんでした
  
パスワードをリセットするコード
onChangeで取得した値を引数に入れる
```dart
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
```

FlutterFireのドキュメントのコード
```dart
await FirebaseAuth.instance
    .sendPasswordResetEmail(email: "user@example.com");
```

[FlutterFireの認証機能関係のリンク](https://firebase.flutter.dev/docs/auth/manage-users)