import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/components/common/relation_chart.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../bloc/relation_chart_data_bloc/bloc.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 10

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  bool isRawTextGenerated = false;
  late TextEditingController rawTextController;

  @override
  void initState() {
    rawTextController = TextEditingController();
    super.initState();
  }

  Future<void> generateRawText() async {
    setState(() {
      isRawTextGenerated = true;
    });
    return;
  }

  Widget _btnGroupBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: !isRawTextGenerated,
          child: Button(
            child: Text(
              'generate',
              style: defaultTextBlack,
            ),
            onPressed: () => generateRawText(),
          ),
        ),
        Visibility(
          visible: isRawTextGenerated,
          child: Button(
            child: Text(
              '1',
              style: defaultTextBlack,
            ),
            onPressed: () => {},
          ),
        ),
        Visibility(
          visible: isRawTextGenerated,
          child: Button(
            child: Text(
              '2',
              style: defaultTextBlack,
            ),
            onPressed: () => {},
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: normalBoxDecoration.copyWith(
                border: normalBorder,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextBox(
                      maxLines: null,
                      controller: rawTextController,
                    ),
                  ),
                  _btnGroupBuilder(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: normalBoxDecoration.copyWith(
                    border: normalBorder,
                  ),
                  child: RelationChart(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
