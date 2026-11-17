import 'package:flutter/cupertino.dart';
import 'package:yahya_todo_app/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _userModel;

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  //get User
  UserModel? getUser() => _userModel;
}