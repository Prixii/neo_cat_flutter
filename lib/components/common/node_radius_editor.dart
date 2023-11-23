import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';

import '../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-11-23 13

class NodeRadiusEditor extends StatefulWidget {
  const NodeRadiusEditor({super.key});

  @override
  State<NodeRadiusEditor> createState() => _NodeRadiusEditorState();
}

class _NodeRadiusEditorState extends State<NodeRadiusEditor> {
  GraphNode _showNode() => tripletEditorBloc(context).state.showNode!;

  Widget _radiusSetterBuilder() {
    return Row(
      children: [
        _functionButtonBuilder(
          'Size Up',
          const Icon(FluentIcons.calculator_subtract),
          () => tripletEditorBloc(context)
              .add(ResizeNode(_showNode().radius - 5, context)),
        ),
        Expanded(
          child: Text(
            _showNode().size.height.toString(),
            style: defaultTextBlack,
            textAlign: TextAlign.center,
          ),
        ),
        _functionButtonBuilder(
          'Size Up',
          const Icon(FluentIcons.calculator_addition),
          () => tripletEditorBloc(context)
              .add(ResizeNode(_showNode().radius + 5, context)),
        ),
      ],
    );
  }

  Widget _functionButtonBuilder(
      String msg, Icon icon, void Function() onPressed) {
    return Tooltip(
      message: msg,
      displayHorizontally: true,
      useMousePosition: false,
      style: const TooltipThemeData(preferBelow: true),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripletEditorBloc, TripletEditorState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'radius',
                  textAlign: TextAlign.center,
                  style: defaultTextBlack,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 3,
                child: _radiusSetterBuilder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
