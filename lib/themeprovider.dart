import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themenotifier extends Notifier<ThemeMode>
{
  @override
  ThemeMode build() {
    loadTheme();
    return ThemeMode.light;
  }

  Future<void> savetheme() async{
     final pre=await SharedPreferences.getInstance();
    pre.setBool('isLight', state==ThemeMode.light);
  }

  Future<void>loadTheme() async {
     final pre=await SharedPreferences.getInstance();
     bool isLight=pre.getBool('isLight') ?? true;
     state=isLight ? ThemeMode.light : ThemeMode.dark;
  }

  void changeTheme()
  {
    state==ThemeMode.light ? state=ThemeMode.dark : state=ThemeMode.light;
    savetheme();
  }
}

final themeNotifierProvider=NotifierProvider<Themenotifier, ThemeMode>((){return Themenotifier();});