import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/initializr/index.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
          color: FluentTheme.of(Navigator.of(context).context)
              .scaffoldBackgroundColor,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    color: Colors.green,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    color: Colors.blue,
                  ),
                  flex: 2),
              Expanded(
                  child: Container(
                    color: Colors.green,
                  ),
                  flex: 1),
            ],
          )),
    );
  }
}
