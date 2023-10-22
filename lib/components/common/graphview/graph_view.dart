import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'graph.dart';
import 'algorithm.dart';
import 'forcedirected/fruchterman_reingold_algorithm.dart';

typedef NodeWidgetBuilder = Widget Function(GraphNode node);

class GraphView extends StatefulWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;
  final NodeWidgetBuilder builder;
  final bool animated;

  const GraphView(
      {Key? key,
      required this.graph,
      required this.algorithm,
      this.paint,
      required this.builder,
      this.animated = true})
      : super(key: key);

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    if (widget.algorithm is FruchtermanReingoldAlgorithm) {
      return _GraphViewAnimated(
        key: widget.key,
        graph: widget.graph,
        algorithm: widget.algorithm,
        paint: widget.paint,
        builder: widget.builder,
      );
    } else {
      return _GraphView(
        key: widget.key,
        graph: widget.graph,
        algorithm: widget.algorithm,
        paint: widget.paint,
        builder: widget.builder,
      );
    }
  }
}

class _GraphView extends MultiChildRenderObjectWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;

  _GraphView(
      {Key? key,
      required this.graph,
      required this.algorithm,
      this.paint,
      required NodeWidgetBuilder builder})
      : super(key: key, children: _extractChildren(graph, builder)) {
    assert(() {
      if (children.isEmpty) {
        throw FlutterError(
          'Children must not be empty, ensure you are overriding the builder',
        );
      }

      return true;
    }());
  }

  // Traverses the nodes depth-first collects the list of child widgets that are created.
  static List<Widget> _extractChildren(Graph graph, NodeWidgetBuilder builder) {
    final result = <Widget>[];

    for (var node in graph.nodes) {
      var widget = builder(node);
      result.add(widget);
    }

    return result;
  }

  @override
  RenderCustomLayoutBox createRenderObject(BuildContext context) {
    return RenderCustomLayoutBox(
      graph,
      algorithm,
      paint,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomLayoutBox renderObject) {
    renderObject
      ..graph = graph
      ..algorithm = algorithm
      ..edgePaint = paint;
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