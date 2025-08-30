import 'package:flutter/material.dart';

final Shader kAppBarTextColor = LinearGradient(
  colors: <Color>[Colors.blue, Colors.orange],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final Color? kHintTextColor = Colors.grey[600];

final Color? kFilterDropdownColor = Colors.grey[100];
