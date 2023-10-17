import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class ClassCreator extends StatefulWidget {
  const ClassCreator({super.key});

  @override
  State<ClassCreator> createState() => _ClassCreatorState();
}

class _ClassCreatorState extends State<ClassCreator> {
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
        onTap: () {
          ContextMenuController.removeAny();
        },
      ),
    );
  }
}
