import 'package:fluent_ui/fluent_ui.dart';

import '../../../types/typdef.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key, required this.options});

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[50],
                offset: const Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 1,
              )
            ],
            color: Colors.grey[10]),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) => options[index],
          ),
        ),
      ),
    );
  }
}

/// 你在哪都能打开这个Popup
/// 请你传入一个函数 [getPosition]，他返回一个 (double, double)
///
/// late OverlayEntry overlayEntry;
///
/// overlayEntry = PopupMenuBuilder(() => position);
///
/// Overlay.of(context).insert(overlayEntry);
///
OverlayEntry popupMenuBuilder(
    {required Position Function() getPosition, required List<Widget> options}) {
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              overlayEntry.remove();
            },
            onSecondaryTapDown: (details) {
              overlayEntry.remove();
            },
          ),
          Positioned(
            top: getPosition().$2,
            left: getPosition().$1,
            height: 320,
            width: 200,
            // child: const PopupMenu(),
            child: PopupMenu(
              options: options,
            ),
          ),
        ],
      ),
    ),
  );
  return overlayEntry;
}
