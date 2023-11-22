import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/state.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';
import 'package:neo_cat_flutter/components/common/graphview/directed_graphview.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/browser_pane.dart';
import 'package:neo_cat_flutter/components/manager/top_btn_group.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11
class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final _widgetControllerBloc = WidgetControllerBloc();

  @override
  void initState() {
    super.initState();
  }

  Widget _editorBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 6, 0),
      child: Container(
        decoration: normalBoxDecoration.copyWith(
          border: normalBorder,
        ),
        child: const Column(
          children: [
            Expanded(
              flex: 1,
              child: TripletEditor(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _relationChartBuilder() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 6, 3, 0),
        child: Container(
          decoration: normalBoxDecoration.copyWith(
            border: normalBorder,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => const GraphClusterViewPage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _widgetControllerBloc,
      child: BlocBuilder<WidgetControllerBloc, WidgetControllerState>(
        builder: (context, state) => ScaffoldPage(
          padding: EdgeInsets.zero,
          content: Container(
            color: FluentTheme.of(Navigator.of(context).context)
                .scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
              child: Row(
                children: [
                  Visibility(
                    visible: _widgetControllerBloc.state.isBrowserPaneVisible,
                    child: const Expanded(
                      flex: 1,
                      child: BrowserPane(),
                    ),
                  ),
                  Expanded(
                    flex: _widgetControllerBloc.state.centerFlexWeight,
                    child: Column(
                      children: [
                        const ButtonGroup(),
                        _relationChartBuilder(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _widgetControllerBloc.state.isEditorPaneVisible,
                    child: Expanded(
                      flex: 1,
                      child: _editorBuilder(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
