import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/test/directed_graphview.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_editing_controller.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_field.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 10

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late RichTextEditingController _richTextEditingController;

  @override
  void initState() {
    _richTextEditingController = RichTextEditingController(context: context);
    super.initState();
  }

  Widget _manualMarkerBuilder() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: richTextFieldBuilder(
          controller: _richTextEditingController,
          context: context,
        ),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _manualMarkerBuilder()),
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
                    child: const GraphClusterViewPage());
              },
            ),
          ),
        ),
      ],
    );
  }
}
