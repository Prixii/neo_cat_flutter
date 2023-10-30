import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/relation_chart_data_bloc/bloc.dart';
import '../../../bloc/relation_chart_data_bloc/state.dart';
import '../../../bloc/triplet_editor_bloc/event.dart';
import '../../../theme/common_theme.dart';
import '../../../types/graph_node.dart';
import '../../../utils/bloc_util.dart';
import 'graph.dart';
import 'algorithm.dart';

typedef NodeWidgetBuilder = Widget Function(GraphNode node);

class GraphView extends StatefulWidget {
  final Algorithm algorithm;
  final Paint? paint;
  final bool animated;

  const GraphView(
      {Key? key, required this.algorithm, this.paint, this.animated = true})
      : super(key: key);

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  Widget circularWidget(GraphNode node) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // 设置鼠标光标为小手指样式
      child: GestureDetector(
        onTap: () {
          tripletEditorBloc(context).add(ChooseNode(newNode: node));
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: relationChartDataBloc(context).getColor(node.label),
                  spreadRadius: 5)
            ],
          ),
          child: Center(
            child: Text(
              relationChartDataBloc(context).state.nodeMap[node.id]?.name ?? '',
              overflow: TextOverflow.ellipsis,
              style: defaultText.copyWith(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => _GraphViewAnimated(
        key: widget.key,
        graph: relationChartDataBloc(context).state.graph!,
        algorithm: widget.algorithm,
        paint: widget.paint,
        builder: (GraphNode node) {
          node.size = const Size(45, 45);
          return circularWidget(node); // 返回一个圆形小部件
        },
      ),
    );
  }
}

class RenderCustomLayoutBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, NodeBoxData>,
        RenderBoxContainerDefaultsMixin<RenderBox, NodeBoxData> {
  late Graph _graph;
  late Algorithm _algorithm;
  late Paint _paint;
  RenderCustomLayoutBox(
    Graph graph,
    Algorithm algorithm,
    Paint? paint, {
    List<RenderBox>? children,
  }) {
    _algorithm = algorithm;
    _graph = graph;
    edgePaint = paint;
    addAll(children);
  }

  Paint get edgePaint => _paint;

  set edgePaint(Paint? value) {
    _paint = value ??
        (Paint()
          ..color = Colors.black
          ..strokeWidth = 3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;
    markNeedsPaint();
  }

  Graph get graph => _graph;

  set graph(Graph value) {
    _graph = value;
    markNeedsLayout();
  }

  Algorithm get algorithm => _algorithm;

  set algorithm(Algorithm value) {
    _algorithm = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! NodeBoxData) {
      child.parentData = NodeBoxData();
    }
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    var child = firstChild;
    var position = 0;
    var looseConstraints = BoxConstraints.loose(constraints.biggest);
    while (child != null) {
      final node = child.parentData as NodeBoxData;

      child.layout(looseConstraints, parentUsesSize: true);
      graph.getNodeAtPosition(position).size = child.size;

      child = node.nextSibling;
      position++;
    }

    size = algorithm.run(graph, 10, 10);

    child = firstChild;
    position = 0;
    while (child != null) {
      final node = child.parentData as NodeBoxData;

      node.offset = graph.getNodeAtPosition(position).position;

      child = node.nextSibling;
      position++;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);

    algorithm.renderer?.render(context.canvas, graph, edgePaint);

    context.canvas.restore();

    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Graph>('graph', graph));
    properties.add(DiagnosticsProperty<Algorithm>('algorithm', algorithm));
    properties.add(DiagnosticsProperty<Paint>('paint', edgePaint));
  }
}

class NodeBoxData extends ContainerBoxParentData<RenderBox> {}

class _GraphViewAnimated extends StatefulWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;
  final nodes = <Widget>[];
  final stepMilis = 25;

  _GraphViewAnimated(
      {Key? key,
      required this.graph,
      required this.algorithm,
      this.paint,
      required NodeWidgetBuilder builder}) {
    for (var node in graph.nodes) {
      nodes.add(builder(node));
    }
  }

  @override
  _GraphViewAnimatedState createState() => _GraphViewAnimatedState();
}

class _GraphViewAnimatedState extends State<_GraphViewAnimated> {
  late Timer timer;
  late Graph graph;
  late Algorithm algorithm;

  @override
  void initState() {
    graph = widget.graph;

    algorithm = widget.algorithm;
    algorithm.init(graph);
    startTimer();

    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: widget.stepMilis), (timer) {
      algorithm.step(graph);
      update();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    algorithm.setDimensions(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: EdgeRender(algorithm, graph, const Offset(20, 20)),
        ),
        ...List<Widget>.generate(graph.nodeCount(), (index) {
          return Positioned(
            top: graph.getNodeAtPosition(index).position.dy,
            left: graph.getNodeAtPosition(index).position.dx,
            child: GestureDetector(
              child: widget.nodes[index],
              onPanUpdate: (details) {
                graph.getNodeAtPosition(index).position += details.delta;
                update();
              },
            ),
          );
        }),
      ],
    );
  }

  Future<void> update() async {
    setState(() {});
  }
}

class EdgeRender extends CustomPainter {
  Algorithm algorithm;
  Graph graph;
  Offset offset;

  EdgeRender(this.algorithm, this.graph, this.offset);

// 设置了画箭头的样式
  @override
  void paint(Canvas canvas, Size size) {
    var edgePaint = (Paint()
      ..color = Colors.black
      ..strokeWidth = 3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    algorithm.renderer!.render(canvas, graph, edgePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
