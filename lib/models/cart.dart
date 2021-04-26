import 'package:flutter/foundation.dart';
import 'package:first_app/models/catalog.dart';

/// VoidCallback()를 이용하여 변경 알림 API를
/// 제공하는 ChangeNotifier를 클래스를 확장한 CartModel 클래스
class CartModel extends ChangeNotifier {
  /// private 변수 + 지연 초기화 변수
  late CatalogModel _catalog;

  /// 아이템의 아이디를 담는 런타임에 결정되는 인트배열 타입을 갖는 private 변수
  final List<int> _itemIds = [];

  /// 지역변수 [_catalog] 를 리턴하는 게터 catalog
  ///
  /// 리턴타입은 CatalogModel
  CatalogModel get catalog => _catalog;

  /// CatalogModel의 값을 설정하는 세터
  ///
  /// 값이 할당되면 [notifyListeners] 통해 모든 리스너를 호출함.
  /// 사용법 CartModel.catalog = 값
  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;

    // 모든 리스너를 호출함.
    notifyListeners();
  }

  /// list타입을 갖는 아이템을 반환 받는 게터
  ///
  /// list.map을 이용하여 id가 같은 요소를 찾고
  /// getById 메소드를 이용하여 아이템을 가져옴.
  /// getById의 리턴 타입은 Item 클래스.
  /// 리턴 타입을 맞추기 위해 .toList로 타입캐스팅.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  /// fold 메소드를 통해 컬렉션의 요소를 반복수행하여 단일 값으로 변경함.
  ///
  /// 0은 초기값, total 이전값, current 현재값
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// 카드 모델에 추가할때 사용됨.
  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }
  /// 카드 모델을 추가할때 사용됨.
  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
