import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/models/cart.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 메테리얼 디자인의 Scaffold 위젯을 만들건데
    return Scaffold(
      // AppBar는 헤드라인1 속성을 같는 텍스트 위젯을 가지고 있고
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      // body Container 위젯 - 레이아웃이 존재하고
      body: Container(
        color: Colors.yellow,
        // 자식 위젯으로는 컬럼 위젯 - 레이아웃으로 이루어 있다.
        child: Column(
          children: [
            // 자식으로는 Expanded 위젯 - flux 레이아웃이 있고
            Expanded(
              // Column 자식으로 패딩 위젯을 - 레이아웃을 가지고 있다.
              child: Padding(
                padding: const EdgeInsets.all(32),
                // 자식으로 _CartList 위젯 - "사용자 작성" 을 가진다
                child: _CartList(),
              ),
            ),
            // Column의 자식으로 Divider 위젯 - 구분선 위젯
            Divider(height: 4, color: Colors.black),
            //  Column의 자식으로 _CartTotal 위젯 - "사용자 작성" 을 가진다.
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 메테리얼 디자인의 Theme 중 헤드라인 6속성
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    /// CartModel 를 구독함. 읽고 쓰기 가능
    ///
    /// .read<CartModel>(); 라면 읽기만 가능
    var cart = context.watch<CartModel>();

    // widgets - ListView 가장 일반적은 스크롤 위젯 (테이블뷰)
    return ListView.builder(
      itemCount: cart.items.length,
      // material - ListView의 아이템
      // 선행, 후행 아이콘이 존재할 수 있는 텍스트가 포함된 위젯
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          // () enable 상태가 되면
          onPressed: () {
            // cart를 지운다!!
            cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // headline1의 본사본을 만드는데 폰트 사이즈는 48이다!
    var hugeStyle =
    Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    // 높이가 200인 빈박스를 생성하고
    return SizedBox(
      height: 200,
      // 자식으로 자식을 중심에 두는 Center 위젯을 가지며
      child: Center(
        // 자식으로 ROW 위젯을 가짐
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CartModel가 변경되면 Consumer가 이를 캐치함.
            Consumer<CartModel>(
              // 빌더를 통해 변화 cart의 값 기준으로 child 위젯, Text 변경됨
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            SizedBox(width: 24),
            /// 스낵바 표시를 위한 API - ScaffoldMessenger
            ///
            /// "Buy" 텍스트 버튼을 누르면 하단에서 스낵바가 올라옴
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
