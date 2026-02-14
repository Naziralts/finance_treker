import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'is_dark_mode';

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

 
  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    final newTheme =
        isDark ? ThemeMode.light : ThemeMode.dark;

    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newTheme == ThemeMode.dark);
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, mode == ThemeMode.dark);
  }

  
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
