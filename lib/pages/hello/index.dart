import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/hello/creat_project_card.dart';
import 'package:neo_cat_flutter/components/hello/open_project_card.dart';

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
              child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CreateProjectCard(),
                          SizedBox(
                            width: 40,
                          ),
                          OpenProjectCard(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )),
        ));
  }
}
