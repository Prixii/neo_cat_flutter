import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/manager/node_tile.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/utils/chart_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

//TODO 状态管理
class ClassManagerTile extends StatefulWidget {
  const ClassManagerTile({super.key, required this.classData});

  final ClassData classData;

  @override
  State<ClassManagerTile> createState() => _ClassManagerTileState();
}

class _ClassManagerTileState extends State<ClassManagerTile> {
  var isVisible = true;
  late List<BaseNode> nodeList;

  @override
  void initState() {
    super.initState();
    nodeList = [];
    _getNodeList();
  }

  Future<void> _getNodeList() async {
    if (widget.classData.name != null) {
      final resultList = await getNodesByClass(
          context: context, className: widget.classData.name!);
      logger.d(resultList);
      nodeList.addAll(resultList);
    }
  }

  Widget _nodeListBuilder() {
    return ListView.builder(
      itemCount: nodeList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => NodeTile(
        node: nodeList[index],
      ),
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
          Text(widget.classData.name ?? '')
        ],
      ),
      content: _nodeListBuilder(),
    );
  }
}
