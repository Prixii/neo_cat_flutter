import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

class SingleMenuOption extends StatefulWidget {
  const SingleMenuOption(
      {super.key, required this.icon, required this.label, this.onTap});

  final Icon icon;
  final String label;
  final Function()? onTap;

  @override
  State<SingleMenuOption> createState() => _SingleMenuOptionState();
}

class _SingleMenuOptionState extends State<SingleMenuOption> {
  Color backgroundColor = opacity;
  late Function() onTap;

  @override
  void initState() {
    super.initState();
    onTap = widget.onTap ?? () => {};
  }

  void _handleHover() {
    setState(() {
      backgroundColor = const Color.fromRGBO(0, 0, 0, 0.04);
    });
  }

  void _handleExit() {
    setState(() {
      backgroundColor = opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: MouseRegion(
        onEnter: (event) => _handleHover(),
        onExit: (event) => _handleExit(),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: backgroundColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: widget.icon,
                  ),
                  SizedBox(
                    height: 36,
                    child: Center(
                      child: Text(
                        widget.label,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
