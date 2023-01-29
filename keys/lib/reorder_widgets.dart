import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  var ints = List<String>.generate(10, (index) => index.toString());
  void _onReorder(int from, int to) {
    setState(() {
      if (from < to) {
        to -= 1;
      }
      final element = ints.removeAt(from);
      ints.insert(to, element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: ints.length,
      itemBuilder: (BuildContext context, int index) {
        return GreenBox(
          ValueKey(ints[index]),
        );
      },
      onReorder: _onReorder,
    );
  }
}

class GreenBox extends StatefulWidget {
  GreenBox(Key? key) : super(key: key) {
    print('🏁 GreenBox init');
  }

  @override
  _GreenBoxState createState() {
    print('GreenBox createState');
    return _GreenBoxState();
  }
}

class _GreenBoxState extends State<GreenBox> {
  var _text = 'start';
  var isDeactivated = false;
  var isDisposed = false;

  void _changeText(String text) {
    _text = text;
    setState(() {});
  }

  _GreenBoxState() {
    print('🎒 GreenBox state init');
  }

  @override
  void initState() {
    super.initState();
    print('GreenBox initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('GreenBox didChangeDependencies');
  }

  @override
  void didUpdateWidget(GreenBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('GreenBox didUpdateWidget');
  }

  @override
  void reassemble() {
    super.reassemble();

    print('GreenBox reassemble');
  }

  @override
  Widget build(BuildContext context) {
    print(
      '🧱 GreenBox build isDeactivated: $isDeactivated, isDisposed: $isDisposed',
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            Text(_text),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: _changeText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print('GreenBox deactivate');
    isDeactivated = true;
    super.deactivate();
  }

  @override
  void dispose() {
    print('GreenBox dispose');
    isDisposed = true;
    super.dispose();
  }
}
