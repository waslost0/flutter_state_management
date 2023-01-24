class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(const Duration(seconds: 1), () {
      return DateTime.now().toIso8601String();
    }).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}
