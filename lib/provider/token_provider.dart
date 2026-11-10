import 'package:flutter/cupertino.dart';

class TokenProvider extends ChangeNotifier {
  String _token = "";

  ///set Token
  void setToken(String val){
    _token = val;
    notifyListeners();
  }

  //get Token
  String getToken() => _token;
}