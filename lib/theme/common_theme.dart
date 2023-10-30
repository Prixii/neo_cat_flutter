/// @author wang.jiaqi
/// @date 2023-09-29 10

import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/gen/fonts.gen.dart';

var lightTheme = FluentThemeData(
  fontFamily: FontFamily.neoCat,
  scaffoldBackgroundColor: Colors.grey[20],
);

final normalBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4),
  color: Colors.white,
);

final normalBorder = Border.all(
  color: const Color.fromARGB(255, 216, 216, 216),
  width: 0.7,
);

const defaultText = TextStyle(
  fontSize: 14,
  fontFamily: FontFamily.neoCat,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

final defaultTextBlack = defaultText.copyWith(color: Colors.black);

const opacity = Color.fromRGBO(0, 0, 0, 0);
final selectedColor = Colors.blue;
