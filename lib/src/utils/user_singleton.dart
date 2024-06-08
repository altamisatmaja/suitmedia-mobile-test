part of 'util.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  String? userName;
}
