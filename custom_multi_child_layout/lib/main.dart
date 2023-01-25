import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          height: 100,
          color: Colors.blue,
          child: CustomMultiChildLayout(
            delegate: CustomMultiChildLayoutDelegate(),
            children: [
              LayoutId(
                id: 1,
                child: Text('Left '),
              ),
              LayoutId(
                id: 2,
                child: Text('middle text'),
              ),
              LayoutId(
                id: 3,
                child: Text('Right teq wd t'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  final double minElementWidth = 50;

  @override
  void performLayout(Size size) {
    if (hasChild(1) && hasChild(2) && hasChild(3)) {
      final leftElementMaxWidth = size.width - minElementWidth * 2;
      final firstElementSize = layoutChild(
        1,
        BoxConstraints.loose(Size(leftElementMaxWidth, size.height)),
      );

      final middleElementMaxWidth =
          size.width - firstElementSize.width - minElementWidth;

      final middleElementSize = layoutChild(
        2,
        BoxConstraints.loose(Size(middleElementMaxWidth, size.height)),
      );

      final lastElementMaxWidth =
          size.width - firstElementSize.width - middleElementSize.width;

      final lastElementSize = layoutChild(
        3,
        BoxConstraints.loose(Size(lastElementMaxWidth, size.height)),
      );

      final firstElementYOffset = size.height / 2 - firstElementSize.height / 2;

      positionChild(1, Offset(0, firstElementYOffset));

      final lastElementYOffset = size.height / 2 - lastElementSize.height / 2;
      final lastElementXOffset = size.width - lastElementSize.width;

      positionChild(3, Offset(lastElementXOffset, lastElementYOffset));

      var middleElementXOffset = size.width / 2 - middleElementSize.width / 2;

      // set the middle element x offset to first element width if the size of
      // first element (width) become more than x position of middle element
      if (firstElementSize.width > middleElementXOffset) {
        middleElementXOffset = firstElementSize.width;

        // if the middle element x position + his width more than last element x
        // then set the middle element x position last element x position - middle width
      } else if (lastElementXOffset <
          middleElementXOffset + middleElementSize.width) {
        middleElementXOffset = lastElementXOffset - middleElementSize.width;
      }

      final middleElementYOffset =
          size.height / 2 - middleElementSize.height / 2;
      positionChild(2, Offset(middleElementXOffset, middleElementYOffset));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
