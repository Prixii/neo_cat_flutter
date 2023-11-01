import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../../types/typdef.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key, required this.options});

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
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
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              logger.e('[close]');
              overlayEntry.remove();
            },
            onSecondaryTapDown: (details) {
              overlayEntry.remove();
            },
          ),
          Positioned(
            top: getPosition().$2,
            left: getPosition().$1,

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
