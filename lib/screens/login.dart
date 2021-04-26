import 'package:flutter/material.dart';

/// 상태 변경이 없는 정적인 MyLogin 위젯 클래스
class MyLogin extends StatelessWidget {

  /// 메테리얼 디자인의 기본 레이아웃 [Scaffold] 빌드함.
  @override
  // BuildContext 위젯트리에서 위젯에 대한 위치를 가지고 있음
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar가 없고 body만 존재하는 레이아웃을 생성함.
      ///
      /// 정렬은 가운데 정렬
      /// AppBar는 네비게이션바를 말함
      body: Center(
        /// 위젯을 분리하거나 마진, 패딩을 줄때 사용됨
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            // Column의 주축 정령은 센터임
            mainAxisAlignment: MainAxisAlignment.center,
            // Column은 children를 가짐
            children: [
              Text( // 라벨 위젯 - widgets(기본)에서 제공
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField( // 텍스트 필드 위젯 - 메테리얼에서 제공
                // 텍스트 필드의 스타일
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField( // 텍스트 필드 위젯 - 메테리얼에서 제공
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox( // 위젯 간 간격을 위한 공간용 위젯 - widgets(기본)에서 제공, swiftui spacer 같은
                height: 24,
              ),
              ElevatedButton( // ElevatedButton - 메테리얼에서 제공
                child: Text('ENTER'),
                onPressed: () {
                  // 스택을 원칙으로 하위 위젯을 관리하는 Navigator 위젯
                  // context 현재 경로
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
