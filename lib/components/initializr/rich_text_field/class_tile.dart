import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../../theme/common_theme.dart';

class ClassTile extends StatefulWidget {
  const ClassTile({super.key, required this.color, required this.className});

  final Color color;
  final ClassName className;

  @override
  State<ClassTile> createState() => _ClassTileState();
}

class _ClassTileState extends State<ClassTile> {
  Color backgroundColor = Colors.transparent;

  Widget _classNameBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
      child: Text(
        widget.className,
        textAlign: TextAlign.left,
        style: defaultTextBlack,
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
            child: Container(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        child: MouseRegion(
          child: SizedBox(
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: backgroundColor,
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: _classNameBuilder()),
                  _colorBoxBuilder(),
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
