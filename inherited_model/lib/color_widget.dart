import 'package:flutter/material.dart';
import 'package:inherited_model/available_colors_widget.dart';
import 'dart:developer' show log;

class ColorWidget extends StatelessWidget {
  final AvailableColors color;

  const ColorWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        log("color1 widget rebuild");
        break;
      case AvailableColors.two:
        log("color2 widget rebuild");
        break;
    }
    var provider = AvailableColorsWidget.of(context, color);

    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}
