import 'package:flutter/material.dart';
import 'package:statefulapp_tut/api_provider.dart';
import 'package:statefulapp_tut/fake_api.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Api api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? "Tap on screen to fetch date and time");
  }
}
