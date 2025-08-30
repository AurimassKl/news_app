import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropdownStyles {
  static const double height = 40;
  static const double borderRadius = 14;
  static const double horizontalPadding = 16;
  static const double maxDropdownHeight = 400;

  static ButtonStyleData buttonStyle({double? width, Color? color}) => ButtonStyleData(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color ?? Colors.grey[100],
        ),
        elevation: 2,
      );

  static DropdownStyleData dropdownStyle({Offset? offset}) => DropdownStyleData(
        maxHeight: maxDropdownHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[100],
        ),
        offset: offset ?? const Offset(0, 0),
        scrollbarTheme: const ScrollbarThemeData(radius: Radius.circular(40)),
      );

  static MenuItemStyleData menuItemStyle() => const MenuItemStyleData(height: height);
}
