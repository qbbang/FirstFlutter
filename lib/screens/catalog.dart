import 'package:flutter/material.dart';
// provider 패키지 사용
import 'package:provider/provider.dart';
// 모델 클래스의 사용
import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';

/// 상태 변경이 없는 정적인 MyCatalog 위젯 클래스
class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CustomScrollView 위젯은 SliverAppBar, SliverList, SliverGrid로 구성 할수있음.
      body: CustomScrollView(
        slivers: [
          _MyAppBar(), // 앱바
          SliverToBoxAdapter(child: SizedBox(height: 12)), // 정적인 셀을 생성하는거 같음... 이 안에 여백 12을 위한 위젯을 생성
          SliverList( // 테이블뷰를 생성하는거
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(index)), //_MyListItem 자식위젯을 생성함
          ),
        ],
      ),
    );
  }
}

/// CustomScrollView에서 표현 될 AppBar 클래스
class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar( // CustomScrollView와 같이 쓰이는 메터리얼 디자인 앱바
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true, // 앱바의 고정 여부
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

/// CustomScrollView에서 SliverList의 자식 위젯 (셀)
class _MyListItem extends StatelessWidget {
  final int index;

  // key - value 형식의 생성자
  // super는  StatelessWidget 생성자를 호출함.
  // this.index는 부모에서 자식위젯(_MyListItem)을 생성할 때 넣어주며
  // 자식의 키를 부모위젯 생성자에게 넘겨 부모가 자식을 관리할 수 있게 함.. 맞나?
  // 팩트 체크 필요
  _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// provider의 .select 소비자: CatalogModel, 리턴타입: Item
    var item = context.select<CatalogModel, Item>(
      // CatalogModel이 변경되면
      // catalog.getByPosition(index)를 통해
      // item를 가져옴
      (catalog) => catalog.getByPosition(index),
    );

    /// textTheme은 메테이얼 디자인의 헤드라인 6 속성을 따름.
    var textTheme = Theme.of(context).textTheme.headline6;

    // 주어진 패딩으로 자식 위젯을 삽입하는 위젯
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        // 자식의 최대 크기가 48
        // maxWidth가 없음으로 너비는 디바이스 사이즈 만큼
        maxHeight: 48,
        // Row 레이아웃을 생성함
        child: Row(
          children: [
            // maxWidth가 무한 이여서 AspectRatio 위젯을 통해 높이와 1:1인 레이아웃을 그림
            AspectRatio(
              aspectRatio: 1,
              // 자식 위젯에 Container 위젯을 넣고 배경색을 지정함
              child: Container(
                color: item.color,
              ),
            ),
            // 24 간격을 줌.
            SizedBox(width: 24),
            //  Flex 한 레이아웃을 만듬
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            // 24 간격을 줌.
            SizedBox(width: 24),
            // 버튼 위젯을 넣음
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

/// 사용자 버튼 위젯
class _AddButton extends StatelessWidget {
  final Item item;

  // 생성자, 부모가 자식 위젯을 관리할 수 있게 슈퍼를 통해 키를 넘김.
  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// provider의 .select 소비자: CartModel, 리턴타입: bool
    var isInCart = context.select<CartModel, bool>(
      // CartModel 변경되면
      // cart 모델의 items에서 addButton를 누른 아이템과 같은 것을 찾아 리턴함.
          (cart) => cart.items.contains(item),
    );

    return TextButton(
      // isInCart true면 null -> Disabled
      // isInCart false VoidCallback -> enabled
      onPressed: isInCart
          ? null
          : () {
        // VoidCallback가 수행할 것
        var cart = context.read<CartModel>();
        cart.add(item);
      },
      // 버튼 스타일을 지정할 수 있음
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      //
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    );
  }
}
