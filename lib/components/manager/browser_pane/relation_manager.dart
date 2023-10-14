import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/state.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/triplet_tile.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 22

class RelationManager extends StatefulWidget {
  const RelationManager({super.key});
  @override
  State<RelationManager> createState() => _RelationManagerState();
}

class _RelationManagerState extends State<RelationManager> {
  final RelationBrowserBloc _relationBrowserBloc = RelationBrowserBloc();

  List<MapEntry<RelationId, Relation>> _getMapEntries() {
    return _relationBrowserBloc.state.relationMap.entries.toList();
  }

  @override
  void initState() {
    super.initState();
    var model = context.read<RelationChartDataBloc>().state.relationChartData;
    _relationBrowserBloc.add(InitRelationBrowserState(model: model));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RelationBrowserBloc>(
      create: (context) => _relationBrowserBloc,
      child: BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
        builder: (context, state) =>
            BlocBuilder<RelationBrowserBloc, RelationBrowserState>(
          builder: (context, state) => ListView.builder(
            itemCount: _relationBrowserBloc.state.relationMap.keys.length,
            itemBuilder: (context, index) {
              var entry = _getMapEntries()[index];
              var relation = entry.value;
              return TripletTile(relation: relation);
            },
          ),
        ),
      ),
    );
  }
}
