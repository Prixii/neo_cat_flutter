import 'package:fluent_ui/fluent_ui.dart';

import '../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 20

class PropertyTile extends StatefulWidget {
  const PropertyTile(
      {super.key, required this.propertyName, this.propertyValue});

  final String propertyName;
  final String? propertyValue;

  @override
  State<PropertyTile> createState() => PropertyTileState();
}

class PropertyTileState extends State<PropertyTile> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController()..text = widget.propertyValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                widget.propertyName,
                textAlign: TextAlign.center,
                style: defaultTextBlack,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: TextBox(
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
