import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';
import 'package:neo_cat_flutter/components/initializr/preview.dart';
import 'package:neo_cat_flutter/model/graph_data_model.dart';
import 'package:neo_cat_flutter/pages/manager/index.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class InitializrPage extends StatefulWidget {
  final String? rawData;

  const InitializrPage({super.key, this.rawData});

  @override
  State<InitializrPage> createState() => _InitializrPageState();
}

class _InitializrPageState extends State<InitializrPage> {
  Future<void> initGraphData() async {
    final newModel = GraphDataModel.fromJson(jsonDecode(widget.rawData ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    void toManager() {
      Navigator.push(
          context, FluentPageRoute(builder: (context) => const ManagerPage()));
    }

    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: FluentTheme.of(Navigator.of(context).context)
            .scaffoldBackgroundColor,
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.orange,
                child: Row(
                  children: [
                    Button(
                      child: const Text('Menu'),
                      onPressed: () => {toManager()},
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.blue,
                        child: Preview(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.purple,
                        child: TripletEditor(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
