import 'package:fluent_ui/fluent_ui.dart';

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
                flex: 1,
                child: Container(
                  color: Colors.green,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          )),
    );
  }
}
