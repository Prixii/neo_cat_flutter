import 'package:fluent_ui/fluent_ui.dart';

import '../../types/typdef.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  Widget cardBuilder() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2), // 阴影偏移量
              blurRadius: 4, // 模糊半径
              spreadRadius: 2,
            )
          ],
          color: Colors.blue,
        ),
        child: const Text("12345678"),
      );

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
                offset: Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 1,
              )
            ],
            color: Colors.grey[10]),
        child: const Text("12345678"),
      ),
    );
  }
}

/// 你在哪都能打开这个Popup
/// 请你传入一个函数 [position]，他返回一个 (double, double)
///
/// late OverlayEntry overlayEntry;
/// overlayEntry = PopupMenuBuilder(() => position);
///
/// onSecondaryTapDown: (details) {
///   setState(
///     () {
///       position = (
///         details.globalPosition.dx,
///         details.globalPosition.dy
///       );
///     },
///   );
///   Overlay.of(context).insert(overlayEntry);
/// },
///
OverlayEntry popupMenuBuilder(Position Function() position) {
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
            top: position().$2,
            left: position().$1,
            height: 320,
            width: 200,
            // child: const PopupMenu(),
            child: const PopupMenu(),
          ),
        ],
      ),
    ),
  );
  return overlayEntry;
}
