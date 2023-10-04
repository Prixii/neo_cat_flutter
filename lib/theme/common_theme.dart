/// @author wang.jiaqi
/// @date 2023-09-29 10

import 'package:fluent_ui/fluent_ui.dart';

var lightTheme =
    FluentThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[20]);

final normalBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4),
  color: Colors.white,
);

final normalBorder = Border.all(
  color: const Color.fromARGB(255, 216, 216, 216),
  width: 0.7,
);