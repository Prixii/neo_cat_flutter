import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/manager/triplet_tile.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class ClassManagerTile extends StatefulWidget {
  const ClassManagerTile({super.key, required this.className});

  final String className;

  @override
  State<ClassManagerTile> createState() => _ClassManagerTileState();
}

class _ClassManagerTileState extends State<ClassManagerTile> {
  var isVisible = true;

  Widget _nodeListBuilder() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => const TripletTile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Row(
        children: [
          Checkbox(
            checked: isVisible,
            onChanged: (value) => setState(
              () {
                isVisible = !isVisible;
              },
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(widget.className)
        ],
      ),
      content: _nodeListBuilder(),
    );
  }
}
