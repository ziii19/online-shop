import 'package:flutter/material.dart';
import 'package:online_shop/presentation/misc/constan.dart';
import 'package:online_shop/presentation/misc/dimens.dart';

class LightTheme {
  LightTheme(this.primaryColor);

  final Color primaryColor;

  InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      fillColor: white,
      filled: true,
      // prefixIconColor: textDisabledColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Dimens.dp16,
        vertical: Dimens.dp12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        borderSide: const BorderSide(color: white),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        borderSide: const BorderSide(color: white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
      ),
    );
  }

  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: navy,
      unselectedItemColor: hitam,
      selectedLabelStyle: TextStyle(
        fontSize: Dimens.dp10,
        color: navy,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Dimens.dp10,
        color: hitam,
      ),
    );
  }

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: scaffold,
      inputDecorationTheme: inputDecorationTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
    );
  }
}
