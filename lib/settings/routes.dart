import 'package:flutter/material.dart';
import 'package:projeto_mobile/screens/new_trip_page.dart';

import '../screens/new_trip_page.dart';
import '../screens/login_page.dart';
import '../screens/menu_page.dart';
import '../screens/order_history_page.dart';
import '../screens/profile_page.dart';
import '../screens/register_page.dart';
class AppRoutes {

  static const String NewTrip = "/new_trip";
  static const String login = "/login";
  static const String menu = "/menu";
  static const String profile = "/profile";
  static const String register = "/register";
  static const String changePassword = "/change_password";
  static const String orderHistory = "/order_history";

  static final Map<String, WidgetBuilder> routes = {
    NewTrip: (context) => NewTripPage(),
    login: (context) => LoginPage(),
    menu: (context) => MenuPage(),
    profile: (context) => ProfilePage(),
    register: (context) => RegisterPage(),
    orderHistory: (context) => OrderHistoryPage(),
  };

}