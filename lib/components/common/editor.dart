import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/global/bloc/relation_chart_data_bloc.dart';
import 'package:neo_cat_flutter/bloc/global/event/relation_chart_data_event.dart';
import 'package:neo_cat_flutter/bloc/global/state/relation_chart_data_state.dart';
import 'package:neo_cat_flutter/components/common/attr_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class TripletEditor extends StatefulWidget {
  const TripletEditor({super.key});

  @override
  State<TripletEditor> createState() => _TripletEditorState();
}

class _TripletEditorState extends State<TripletEditor> {
  String _getSourceNodeName() {
    BaseNode? sourceNode =
        context.read<RelationChartDataBloc>().state.tripletDataModel.sourceNode;
    if (sourceNode != null) {
      return sourceNode.name;
    }
    return '待选择';
  }

  String _getEndNodeName() {
    BaseNode? endNode =
        context.read<RelationChartDataBloc>().state.tripletDataModel.endNode;
    if (endNode != null) {
      return endNode.name;
    }
    return '待选择';
  }

  String _getRelationName() {
    BaseRelation? relation =
        context.read<RelationChartDataBloc>().state.tripletDataModel.relation;
    if (relation != null) {
      return relation.name;
    }
    return '待选择';
  }

  Widget _tripletEditorBuilder() {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onSecondaryTap: () => {
                  context
                      .read<RelationChartDataBloc>()
                      .add(const RemoveNodeFromTripletEvent(nodeIndex: 0))
                },
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: CirclePainter(),
                        );
                      },
                    ),
                    Center(
                      child: Text(_getSourceNodeName()),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: ArrowPainter(),
                        );
                      },
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(_getRelationName()),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onSecondaryTap: () => {
                  context
                      .read<RelationChartDataBloc>()
                      .add(const RemoveNodeFromTripletEvent(nodeIndex: 1))
                },
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: CirclePainter(),
                        );
                      },
                    ),
                    Center(
                      child: Text(_getEndNodeName()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attrListBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return const AttributeTile();
        },
      ),
    );
  }

  Widget _confirmBtnBuilder() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Button(
          child: const Center(
            child: Text(
              'confirm',
            ),
          ),
          onPressed: () => {
            context.read<RelationChartDataBloc>().add(
                  ChooseNodeEvent(
                    // TODO 选择节点
                    node: BaseNode(name: 'newNode', id: 'a', className: 'cls'),
                  ),
                ),
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
        builder: (context, RelationChartDataState state) {
      return Column(
        children: [
          _tripletEditorBuilder(),
          const Divider(),
          Expanded(
            child: Container(
              decoration: normalBoxDecoration,
              child: _attrListBuilder(),
            ),
          ),
          _confirmBtnBuilder(),
        ],
      );
    });
  }
}
