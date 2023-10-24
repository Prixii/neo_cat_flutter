import 'package:fluent_ui/fluent_ui.dart';

import '../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 20

class PropertyTile extends StatefulWidget {
  const PropertyTile(
      {super.key, required this.propertyName, required this.controller});
  final TextEditingController controller;
  final String propertyName;

  @override
  State<PropertyTile> createState() => PropertyTileState();
}

class PropertyTileState extends State<PropertyTile> {
  @override
  void initState() {
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
                controller: widget.controller,
                style: defaultTextBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
