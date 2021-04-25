// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';   // 메테리얼 디자인 적용을 위한 패키지 사용
import 'package:provider/provider.dart';  // 상태관리를 위해 provider 패키지 사용
// 사용자가 만든 유틸, 모델, 화면 패키지 사용
import 'package:first_app/common/theme.dart';
import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';
import 'package:first_app/screens/cart.dart';
import 'package:first_app/screens/catalog.dart';
import 'package:first_app/screens/login.dart';

// 프로그램 시작지점
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
