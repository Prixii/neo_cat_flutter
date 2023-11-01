import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/initializr/create_label_dialog.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

import 'rich_text_editing_controller.dart';

class LabelSetter extends StatefulWidget {
  const LabelSetter({super.key, required this.getController});

  final RichTextEditingController Function() getController;

  @override
  State<LabelSetter> createState() => _LabelSetterState();
}

class _LabelSetterState extends State<LabelSetter> {
  Color backgroundColor = Colors.transparent;

  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          showCreateClassDialog(context, widget.getController);
          ContextMenuController.removeAny();
        },
        child: MouseRegion(
          child: SizedBox(
            height: 30,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: backgroundColor,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '添加新的类',
                    textAlign: TextAlign.center,
                    style: defaultTextBlack,
                  ),
                ],
              ),
            ),
          ),
          onEnter: (event) => setState(() {
            backgroundColor = Colors.black.withOpacity(0.05);
          }),
          onExit: (event) => setState(() {
            backgroundColor = Colors.transparent;
          }),
        ),
      ),
    );
  }
}
