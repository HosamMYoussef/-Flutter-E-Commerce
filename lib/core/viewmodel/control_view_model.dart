import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/Favorites_view.dart';

import '../../view/auth/login_screen.dart';
import '../../view/cart_view.dart';
import '../../view/home_view.dart';
import '../../view/profile_view.dart';


class ControlViewModel extends GetxController {
    Widget _currentScreen = HomeView();

  int _navigatorvalue = 0;
  get navigatorvalue => _navigatorvalue;
  get currentScreen => _currentScreen;
  void changeSelectedvalue(int selectedValue) {
    _navigatorvalue = selectedValue;
              switch (selectedValue) {
            case 0:
              {
                _currentScreen = HomeView();
                break;
              }
            case 1:
              {
                _currentScreen = CartView();
                break;
              }
            case 2:
              {
                _currentScreen = FavoritesView();
                break;
              }
            case 3:
              {
                _currentScreen = ProfileView();
                break;
              }
          }
    update();
  }
}
