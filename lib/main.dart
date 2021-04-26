import 'package:flutter/material.dart';    // 메테리얼 디자인 적용을 위한 패키지 사용
import 'package:flutter/cupertino.dart';   // 쿠퍼티노 디자인 적용을 위한 패키지 사용
import 'package:provider/provider.dart';   // 상태관리를 위해 provider 패키지 사용
// 사용자가 만든 유틸, 모델, 화면 패키지 사용
import 'package:first_app/common/theme.dart';
import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';
import 'package:first_app/screens/cart.dart';
import 'package:first_app/screens/catalog.dart';
import 'package:first_app/screens/login.dart';

/// 프로그램 시작지점
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return MultiProvider(
      providers: [
        // Create - Dispose 쌍으로 이루어진 생명주기를 가진 Provider를 Root에 생성함
        Provider(create: (context) => CatalogModel()),
        // ChangeNotifierProxyProvider 종속적인 관계가 있을 때 사용됨
        // CatalogModel 값을 기준으로 CartModel를 Provider 할때!!
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          // Create - Dispose 쌍으로 이루어진 생명주기를 가진 Provider를 Root에 생성하고
          create: (context) => CartModel(),
          // CatalogModel 데이터가 변경되 었을 때 어떻게 다시 빌드 할지 정해준다.
          update: (context, catalog, cart) {
            // 한줄 표현식 같음, null이면 throw 통해 강제로 에러를 발생시킴
            // ArgumentError.notNull -> null이 안되는데 null이라는 에러
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      // routes가 정의된 머티리얼 디자인을 사용하는 애플리케이션
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',  //초기화 시 경로
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
