import 'package:flutter/material.dart';

class HomeTabAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AppBar롤 Scaffold의 appBar 속성내에 사용하지 않을 경우 몇가지 제한사항이 있음
    // bottom 속성 등. 하지만 해당 속성을 사용하지 않을거기 때문에 사용
    return AppBar(
      title: Text('온천동'),
      actions: [
        GestureDetector(
          onTap: () {
            print("search");
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
