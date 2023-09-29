import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: lightTheme,
      home: const ScaffoldPage(
        content: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
