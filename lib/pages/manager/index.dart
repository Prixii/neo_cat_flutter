import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';
import 'package:neo_cat_flutter/components/common/top_bar.dart';
import 'package:neo_cat_flutter/components/manager/class_manager_view.dart';
import 'package:neo_cat_flutter/components/manager/function_btn_group.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  Widget _classManagerBuilder() {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) => ClassManagerView(
          className: 'class$index',
        ),
      ),
    );
  }

  Widget _editorBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 6, 0),
      child: Container(
        decoration: normalBoxDecoration.copyWith(
          border: normalBorder,
        ),
        child: const Column(
          children: [
            Expanded(
              flex: 1,
              child: TripletEditor(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _relationChartBuilder() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 6, 3, 0),
        child: Container(
          decoration: normalBoxDecoration.copyWith(
            border: normalBorder,
          ),
          child: const Center(
            child: Text('你是一个一个一个关系图啊啊啊啊啊啊'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: FluentTheme.of(Navigator.of(context).context)
            .scaffoldBackgroundColor,
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _classManagerBuilder(),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const FunctionButtonGroup(),
                            _relationChartBuilder(),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: _editorBuilder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
