import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/relation_chart_data_bloc/bloc.dart';
import '../../../bloc/relation_chart_data_bloc/state.dart';
import '../../../types/source_edge.dart';
import '../../../utils/bloc_util.dart';
import 'triplet_tile.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 22

class RelationManager extends StatefulWidget {
  const RelationManager({super.key});
  @override
  State<RelationManager> createState() => _RelationManagerState();
}

class _RelationManagerState extends State<RelationManager> {
  @override
  void initState() {
    super.initState();
  }

  List<SourceEdge> getRelationList() =>
      relationChartDataBloc(context).state.relationMap.values.toList();

  @override
  Widget build(BuildContext context) {
    var relationList = getRelationList();
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => ListView.builder(
        itemCount: relationList.length,
        itemBuilder: (context, index) {
          var relation = relationList[index];
          return TripletTile(relation: relation);
        },
      ),
    );
  }
}
