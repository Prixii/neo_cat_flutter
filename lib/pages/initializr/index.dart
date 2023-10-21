import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/bloc.dart';
import 'package:neo_cat_flutter/components/initializr/preview.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

import '../../bloc/class_browser_bloc/event.dart';
import '../../bloc/relation_chart_data_bloc/bloc.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class InitializrPage extends StatefulWidget {
  const InitializrPage({super.key});

  @override
  State<InitializrPage> createState() => _InitializrPageState();
}

class _InitializrPageState extends State<InitializrPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClassBrowserBloc>().add(
          InitClassBrowserState(
            model:
                context.read<RelationChartDataBloc>().state.relationChartData,
          ),
        );
  }

  Widget _editorBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
      child: Container(
          decoration: normalBoxDecoration.copyWith(
            border: normalBorder,
          ),
          child: Container()),
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
