import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(runtimeType.toString());
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStateful(),
      ),
    );
  }
}

class DataOwnerStateful extends StatefulWidget {
  const DataOwnerStateful({Key? key}) : super(key: key);

  @override
  State<DataOwnerStateful> createState() => _DataOwnerStatefulState();
}

class _DataOwnerStatefulState extends State<DataOwnerStateful> {
  var _value = 0;

  void _increment() {
    setState(() {
      _value += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(runtimeType.toString());
    return Column(
      children: [
        ElevatedButton(
          onPressed: _increment,
          child: const Text("tap"),
        ),
        DataProviderInherited(
          value: _value,
          child: const DataConsumerStateless(),
        ),
      ],
    );
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(runtimeType.toString());
    final value = context
        .dependOnInheritedWidgetOfExactType<DataProviderInherited>()
        ?.value;
    return Column(
      children: [
        Text("$value"),
        const DataConsumerStateful(),
      ],
    );
  }
}

class DataConsumerStateful extends StatefulWidget {
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  State<DataConsumerStateful> createState() => _DataConsumerStatefulState();
}

class _DataConsumerStatefulState extends State<DataConsumerStateful> {
  @override
  Widget build(BuildContext context) {
    debugPrint(runtimeType.toString());
    final element = context
        .getElementForInheritedWidgetOfExactType<DataProviderInherited>();
    return Text("${(element?.widget as DataProviderInherited).value}");
  }
}

class DataProviderInherited extends InheritedWidget {
  final int value;

  const DataProviderInherited({
    super.key,
    required this.value,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant DataProviderInherited oldWidget) {
    return value != oldWidget.value;
  }

  static DataProviderInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  }
}
