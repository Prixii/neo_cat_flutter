import 'package:flutter/material.dart' show Material;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/bloc/node/node_event.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import 'rich_text_field/rich_text_editing_controller.dart';

void showCreateClassDialog(BuildContext context,
    RichTextEditingController Function() getController) async {
  await showDialog(
    context: context,
    builder: (context) => ClassCreator(
      context: context,
      getController: getController,
    ),
  );
}

class ClassCreator extends StatefulWidget {
  const ClassCreator({
    super.key,
    required this.context,
    required this.getController,
  });

  final BuildContext context;
  final RichTextEditingController Function() getController;

  @override
  State<ClassCreator> createState() => _ClassCreatorState();
}

class _ClassCreatorState extends State<ClassCreator> {
  Color pickerColor = Colors.blue;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Widget _titleBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
      child: Center(
        child: Text(
          '创建Class',
          style: defaultTextBlack.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _colorBoxBuilder() {
    return SizedBox(
      width: 30,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Container(color: pickerColor),
          ),
        ),
      ),
    );
  }

  Widget _buttonGroupBuilder() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.1)),
            ),
            height: 36,
            width: double.infinity,
            child: Center(
              child: Text(
                'Cancel',
                style: defaultText.copyWith(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 12,
      ),
      Expanded(
        flex: 2,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            _creatAndSetLabel();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
            height: 36,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Create',
                style: defaultText,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void _creatAndSetLabel() {
    var start = widget.getController().selection.start;
    var end = widget.getController().selection.end;
    var newText = widget.getController().text;
    var head = newText.substring(0, start);
    var center = newText.substring(start, end);
    var tail = newText.substring(end);
    newText = "$head€${_controller.text}£$center $tail";
    widget.getController().text = newText;
    var labelData = LabelData(
        name: _controller.text, properties: [], color: pickerColor.toHex());
    var newNode = GraphNode(
        name: center,
        id: "${_controller.text},$center".hashCode,
        label: _controller.text,
        properties: {});
    relationChartDataBloc(context)
        .add(CreateLabelAndSetNode(labelData, newNode, false));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        constraints: const BoxConstraints(
          maxWidth: 368.0,
          maxHeight: 356.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _titleBuilder(),
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextBox(
                        controller: _controller,
                        autofocus: true,
                        placeholder: 'Class Name',
                      ),
                    ),
                    _colorBoxBuilder(),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Material(
                    child: SlidePicker(
                      showIndicator: false,
                      enableAlpha: false,
                      pickerColor: pickerColor,
                      onColorChanged: (Color newColor) => setState(() {
                        pickerColor = newColor;
                      }),
                    ),
                  ),
                ),
              ),
              _buttonGroupBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
