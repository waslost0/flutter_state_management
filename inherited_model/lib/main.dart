import 'package:flutter/material.dart';
import 'package:inherited_model/available_colors_widget.dart';
import 'package:inherited_model/color_widget.dart';
import 'package:inherited_model/inherit_model_example.dart';
import 'package:inherited_model/iterable_extension.dart';
import 'package:inherited_model/simple_calc.dart';

final colors = [
  Colors.orange,
  Colors.red,
  Colors.grey,
  Colors.green,
  Colors.amber,
  Colors.blue,
  Colors.cyan,
];

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
      home: const SimpleCalc(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color1 = Colors.yellow;
  Color color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text("Change color 1"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text("Change color 2"),
                ),
              ],
            ),
            const ColorWidget(
              color: AvailableColors.one,
            ),
            const ColorWidget(
              color: AvailableColors.two,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
