import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final key = GlobalKey<_AwesomeTextState>();

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => key.currentState?._increment(),
            child: Text('Увеличить'),
          ),
          AwesomeText(
            key: key,
          )
        ],
      ),
    );
  }
}

class AwesomeText extends StatefulWidget {
  AwesomeText({Key? key}) : super(key: key);

  @override
  _AwesomeTextState createState() => _AwesomeTextState();
}

class _AwesomeTextState extends State<AwesomeText> {
  var _value = 0;
  void _increment() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$_value'),
    );
  }
}
