import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class LocalStorageUser extends GetxController {
  // Future<UserModel> get getUser async {
  //   try {
  //     UserModel userModel = await getUserData();
  //     if (userModel == null) {
  //       return null;
  //     }
  //     return userModel;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var value = prefs.getString('user');
  //   return UserModel.fromJson(Json.decode(value));
  // }

  // setUser(UserModel userModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   await prefs.setString('user', json.encode(userModel.toJson()));
  // }

  static setUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userModel.toJson()));
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserModel.fromJson(
        json.decode(prefs.getString('user')!) as Map<dynamic, dynamic>);
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
