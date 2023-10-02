import 'package:fluent_ui/fluent_ui.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 20

class AttributeTile extends StatefulWidget {
  const AttributeTile({super.key});

  @override
  State<AttributeTile> createState() => AttributeTileState();
}

class AttributeTileState extends State<AttributeTile> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '114',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: TextBox(),
            )
          ],
        ),
      ),
    );
  }
}
