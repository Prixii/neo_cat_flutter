import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/create_class_dialog.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

class ClassSetter extends StatefulWidget {
  const ClassSetter({super.key});

  @override
  State<ClassSetter> createState() => _ClassSetterState();
}

class _ClassSetterState extends State<ClassSetter> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          showCreateClassDialog(context);
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
