
import 'package:flutter/foundation.dart';
import 'package:flutter_b18_backend/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  UserModel getUser() => _userModel;
}