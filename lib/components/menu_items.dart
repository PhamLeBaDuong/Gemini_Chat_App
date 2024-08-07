import 'package:flutter/material.dart';
import 'package:namer_app/components/menu_item.dart';

class MenuItems {
  static const List<MenuItem> items = [itemSignOut];
  static const itemSignOut = MenuItem(text: "Sign Out", icon: Icons.logout);
}
