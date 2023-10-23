import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import '../../../types/graph_node.dart';
import '../graphview/algorithm.dart';
import '../graphview/forcedirected/fruchterman_reingold_algorithm.dart';
import '../graphview/graph.dart';
import '../graphview/graph_view.dart';

class GraphClusterViewPage extends StatefulWidget {
  const GraphClusterViewPage({
    super.key,
  });
  @override
  State<GraphClusterViewPage> createState() => _GraphClusterViewPageState();
}

class _GraphClusterViewPageState extends State<GraphClusterViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => InteractiveViewer(
        constrained: false, // 设置是否限制用户缩放
        boundaryMargin: const EdgeInsets.all(1000), // 设置边界边距
        minScale: 0.1, // 设置最小缩放比例
        maxScale: 10, // 设置最大缩放比例
        child: GraphView(
          graph: graph, // 设置要显示的图形
          algorithm: builder, // 设置图形布局算法
          builder: (GraphNode node) {
            node.size = const Size(45, 45);
            var i = node.id; // 获取节点的key
            String? name = node.name; // 获取节点的名字
            return circularWidget(i, name); // 返回一个圆形小部件
          },
        ),
      ),
    );
  }

  Widget circularWidget(int? i, String? name) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // 设置鼠标光标为小手指样式
      child: GestureDetector(
        onTap: () {
          // TODO 点击事件
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 5)],
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            child: Text(
              name!,
              style: defaultTextBlack,
            ),
          ),
        ),
      ),
    );
  }

  final Graph graph = Graph();
  late Algorithm builder;

  @override
  void initState() {
    super.initState();
    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }
}
