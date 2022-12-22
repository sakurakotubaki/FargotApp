import 'package:fargot_password/fargot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// GoRouterの画面遷移の設定
final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    /// 最初のページのページへ移動する設定
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const MyHomePage(),
      routes: <GoRoute>[
        /// ログイン後のページへ画面遷移する設定
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) => HomePage(),
        ),

        /// パスワードをリセットするページへ画面遷移する設定
        GoRoute(
          path: 'fargot',
          builder: (BuildContext context, GoRouterState state) =>
              const FargotPassword(),
        ),
      ],
    ),
  ],
);

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 入力したメールアドレス・パスワード
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: () async {
                  try {
                    final User? user = (await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null)
                      print("ユーザ登録しました ${user.email} , ${user.uid}");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) context.go('/home');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    context.go('/fargot');
                  },
                  child: Text('パスワードを忘れた'))
            ],
          ),
        ),
      ),
    );
  }
}
