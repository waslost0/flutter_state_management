import 'package:flutter/material.dart';

class SimpleCalc extends StatelessWidget {
  const SimpleCalc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SimpleCalcWidget(),
    );
  }
}

class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalcWidgetProvider(
          model: model,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FirstNumberWidget(),
              SizedBox(height: 10),
              SecondNumberWidget(),
              SizedBox(height: 10),
              SumButtonWidget(),
              SizedBox(height: 10),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType");
    return TextField(
      onChanged: (value) {
        SimpleCalcWidgetProvider.read(context)?.firstNumber = value;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType");
    return TextField(
      onChanged: (value) =>
          SimpleCalcWidgetProvider.read(context)?.secondNumber = value,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType");
    return ElevatedButton(
      onPressed: () => SimpleCalcWidgetProvider.read(context)?.sum(),
      child: const Text('calc'),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType");
    final value = SimpleCalcWidgetProvider.watch(context)?.sumResult ?? -1;
    return Text("$value");
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);

  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void sum() {
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = -1;
    }
    if (this.sumResult != sumResult) {
      this.sumResult = sumResult;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider
    extends InheritedNotifier<SimpleCalcWidgetModel> {
  const SimpleCalcWidgetProvider({
    super.key,
    required SimpleCalcWidgetModel model,
    required super.child,
  }) : super(notifier: model);

  static SimpleCalcWidgetModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
        ?.notifier;
  }

  static SimpleCalcWidgetModel? read(BuildContext context) {
    // if do not need to subscribe for model change. FirstNumberWidget, SecondNumberWidget, SumButtonWidget
    return (context
            .getElementForInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()
            ?.widget as SimpleCalcWidgetProvider)
        .notifier;
  }
}
