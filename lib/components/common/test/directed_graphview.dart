import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import '../graphview/algorithm.dart';
import '../graphview/forcedirected/fruchterman_reingold_algorithm.dart';
import '../graphview/graph_view.dart';

class GraphClusterViewPage extends StatefulWidget {
  const GraphClusterViewPage({
    super.key,
  });

  @override
  State<GraphClusterViewPage> createState() => _GraphClusterViewPageState();
}

class _GraphClusterViewPageState extends State<GraphClusterViewPage> {
  late Algorithm builder;

  @override
  void initState() {
    super.initState();
    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false, // 设置是否限制用户缩放
      boundaryMargin: const EdgeInsets.all(1000), // 设置边界边距
      minScale: 0.1, // 设置最小缩放比例
      maxScale: 10, // 设置最大缩放比例
      child: BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
        builder: (context, state) => GraphView(
          algorithm: builder, // 设置图形布局算法
        ),
      ),
    );
  }
}
