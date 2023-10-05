import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';
import 'package:neo_cat_flutter/components/initializr/preview.dart';
import 'package:neo_cat_flutter/model/graph_data_model.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
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
    logger.d(newModel);
  }

  Widget _editorBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
      child: Container(
        decoration: normalBoxDecoration.copyWith(
          border: normalBorder,
        ),
        child: const TripletEditor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: FluentTheme.of(Navigator.of(context).context)
            .scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Center(
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Preview(),
                ),
                Expanded(
                  flex: 1,
                  child: _editorBuilder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
