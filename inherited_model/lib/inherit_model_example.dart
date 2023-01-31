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
  var _value1 = 0;
  var _value2 = 0;

  void _increment1() {
    setState(() {
      _value1 += 1;
    });
  }

  void _increment2() {
    setState(() {
      _value2 += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(runtimeType.toString());
    return Column(
      children: [
        ElevatedButton(
          onPressed: _increment1,
          child: const Text("tap"),
        ),
        ElevatedButton(
          onPressed: _increment2,
          child: const Text("tap"),
        ),
        DataProviderInherited(
          value1: _value1,
          value2: _value2,
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
        .dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 0)
        ?.value1;
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
        .dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 1);
    return Text("${element?.value2}");
  }
}

class DataProviderInherited extends InheritedModel<int> {
  final int value1;
  final int value2;

  const DataProviderInherited({
    super.key,
    required this.value1,
    required this.value2,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant DataProviderInherited oldWidget) {
    return value1 != oldWidget.value1 || value2 != oldWidget.value2;
  }

  static DataProviderInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherited oldWidget, Set<int> dependencies) {
    return value1 != oldWidget.value1 && dependencies.contains(0) ||
        value2 != oldWidget.value2 && dependencies.contains(1);
  }
}
