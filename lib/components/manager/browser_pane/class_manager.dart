import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/class_manager_tile.dart';

class ClassManager extends StatefulWidget {
  const ClassManager({super.key});

  @override
  State<ClassManager> createState() => _ClassManagerState();
}

class _ClassManagerState extends State<ClassManager> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListView.builder(
          itemCount: 6,
          // itemCount: classDataList.length,
          itemBuilder: (BuildContext context, int index) =>
              //  ClassManagerTile(
              // classData: classDataList[index],
              // ),
              Container()),
    );
  }
}
