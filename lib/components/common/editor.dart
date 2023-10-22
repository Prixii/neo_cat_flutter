import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/components/common/property_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/enums.dart';
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
  @override
  void initState() {
    super.initState();
  }

  TripletEditorBloc _getTripletEditorBloc() =>
      context.read<TripletEditorBloc>();

  String _getSourceNodeName() {
    Node? sourceNode = _getTripletEditorBloc().state.sourceNode;
    if (sourceNode != null) {
      return sourceNode.name;
    }
    return '待选择';
  }

  String _getEndNodeName() {
    Node? endNode = _getTripletEditorBloc().state.endNode;
    if (endNode != null) {
      return endNode.name;
    }
    return '待选择';
  }

  String _getRelationName() {
    Relation? relation = _getTripletEditorBloc().state.relation;
    if (relation != null) {
      return relation.type;
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
                onSecondaryTap: () => _getTripletEditorBloc()
                    .add(RemoveNode(position: TripletPosition.source)),
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
                      child: Text(
                        _getSourceNodeName(),
                        style: defaultText,
                      ),
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
                            child: Text(
                              _getRelationName(),
                              style: defaultTextBlack,
                            ),
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
                onSecondaryTap: () => _getTripletEditorBloc()
                    .add(RemoveNode(position: TripletPosition.end)),
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
                      child: Text(
                        _getEndNodeName(),
                        style: defaultText,
                      ),
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

  Widget _propertiesListBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return const PropertyTile();
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
          child: Center(
            child: Text(
              'confirm',
              style: defaultTextBlack,
            ),
          ),
          onPressed: () => {
            // TODO 提交实现
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tripletEditorBuilder(),
        const Divider(),
        Expanded(
          child: Container(
            decoration: normalBoxDecoration,
            child: _propertiesListBuilder(),
          ),
        ),
        _confirmBtnBuilder(),
      ],
    );
  }
}
