/// 메테리얼 디자인의 기본 색상을 사용하기 위한 패키지 추가
import 'package:flutter/material.dart';

class CatalogModel {
  /// 문자열 배열 itemNames 클래스 변수 -> static 변수는 호출 될때까지 초기화되지 않음
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  /// [id] 기준으로 Item를 가져옴
  ///
  /// Item을 리턴하고 매개변수로 id를 받음
  /// => { return expr; } 의 축약형
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// [position] 기준으로 아이템을 가져옴
  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable // @immutable 인스턴스화 되면 불변
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  /// Item(this.id, this.name) 형태로 생성자를 호출하면 color도 대입 됨.
  ///
  /// Item(this.id, this.name) 형태를 갖는 Named constructors
  Item(this.id, this.name)
      // Colors.primaries은 메테리얼 디자인에서 제공하는 기본 색상의 배열
      : color = Colors.primaries[id % Colors.primaries.length];

  // 모든 객체에는 hashCode가 존재하기 때문에 @override
  @override
  int get hashCode => id;

  // (Object other)이 참일때 동작하는 operator, operator도 기본연산자로 있음
  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
