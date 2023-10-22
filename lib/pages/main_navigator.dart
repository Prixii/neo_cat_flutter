import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';
import 'package:neo_cat_flutter/pages/save/index.dart';

import '../bloc/relation_chart_data_bloc/bloc.dart';
import 'initializr/index.dart';
import 'manager/index.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key, this.rawData});
  final String? rawData;

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int topIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.rawData != null) {
      context.read<RelationChartDataBloc>().add(
            InitRelationChartData(rawData: widget.rawData!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(
          () {
            topIndex = index;
          },
        ),
        displayMode: PaneDisplayMode.top,
        items: pageItems,
      ),
    );
  }
}

List<NavigationPaneItem> pageItems = [
  PaneItem(
    icon: const Icon(FluentIcons.dataflows_link),
    body: const InitializrPage(),
  ),
  PaneItem(
    icon: const Icon(FluentIcons.cube_shape),
    body: const ManagerPage(),
  ),
  PaneItem(
    icon: const Icon(FluentIcons.save),
    body: const SavePage(),
  ),
];
