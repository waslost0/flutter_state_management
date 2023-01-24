import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AvailableColors {
  one,
  two;
}

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final Color color1;
  final Color color2;

  const AvailableColorsWidget({
    required this.color1,
    required this.color2,
    super.key,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    log("updateShouldNotify");
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    log("updateShouldNotifyDependent");
    log(dependencies.toString());
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) =>
      InheritedModel.inheritFrom<AvailableColorsWidget>(
        context,
        aspect: aspect,
      )!;
}
