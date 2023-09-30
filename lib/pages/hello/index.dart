import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/manager/index.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class HelloPage extends StatefulWidget {
  const HelloPage({super.key});

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: EdgeInsets.zero,
        content: Container(
          color: FluentTheme.of(Navigator.of(context).context)
              .scaffoldBackgroundColor,
          child: Center(
            child: Button(
              onPressed: () => {
                Navigator.push(context,
                    FluentPageRoute(builder: (context) => ManagerPage()))
              },
              child: const Text('here is Hello'),
            ),
          ),
        ));
  }
}
