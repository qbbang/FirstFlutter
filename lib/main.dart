// 메테리얼 패키지 임포트
import 'package:flutter/material.dart';

// runApp 는 위젯 트리의 루트로 만듬.
void main() => runApp(MyApp());

// StatelessWidget는 빌드 시 단 한번만 그려짐
// StatefulWidget는 state 포함하며, setState가 발생할때마다 build됨 동적인거
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
			https://api.flutter.dev/flutter/material/MaterialApp-class.html
    */
    return MaterialApp(
      title: 'title Welcome to Flutter',
      // iOS NavigationBar + Tabbar 섞은거?
      home: Scaffold(
        appBar: AppBar( // NavigationBar
          title: Text('appBar Welcome to Flutter'), // 우선순
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}