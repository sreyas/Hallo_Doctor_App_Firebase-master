import 'package:fluttertoast/fluttertoast.dart';

class MyExceptions implements Exception {
  final String message;

  MyExceptions(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

final couldNotConnect = MyExceptions('could not connect');

void exceptionToast(String message) {
  Fluttertoast.showToast(msg: message);
}
