import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';
import 'package:neo_cat_flutter/components/common/relation_chart.dart';
import 'package:neo_cat_flutter/components/manager/class_manager_view.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/manager_view_mode.dart';

import '../../bloc/global/bloc/relation_chart_data_bloc.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11
class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  ViewMode currentViewMode = ViewMode.classMode;
  bool isBrowserPaneVisible = true;
  bool isEditorPaneVisible = true;
  int centerFlexWeight = 2;
  late List<ClassData> classDataList;

  @override
  void initState() {
    super.initState();
    classDataList = context
        .read<RelationChartDataBloc>()
        .state
        .chartDataModel
        .classDataList;
  }

  void _switchViewMode() {
    switch (currentViewMode) {
      case ViewMode.classMode:
        {
          setState(() {
            currentViewMode = ViewMode.relationMode;
          });
          break;
        }
      case ViewMode.relationMode:
        {
          setState(() {
            currentViewMode = ViewMode.classMode;
          });
          break;
        }
    }
  }

  void _swichBrowserPane() {
    setState(() {
      if (isBrowserPaneVisible) {
        centerFlexWeight += 1;
      } else {
        centerFlexWeight -= 1;
      }
      isBrowserPaneVisible = !isBrowserPaneVisible;
    });
  }

  void _switchEditorPane() {
    setState(() {
      if (isEditorPaneVisible) {
        centerFlexWeight += 1;
      } else {
        centerFlexWeight -= 1;
      }
      isEditorPaneVisible = !isEditorPaneVisible;
    });
  }

  Widget _browserModeBtnBuilder() {
    return Row(
      children: [
        Tooltip(
          message: '类视图',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon: currentViewMode == ViewMode.classMode
                ? classViewBtnActive
                : classViewBtn,
            onPressed: () => currentViewMode == ViewMode.classMode
                ? null
                : _switchViewMode(),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: '关系视图',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon: currentViewMode == ViewMode.relationMode
                ? relationViewBtnActive
                : relationViewBtn,
            onPressed: () => currentViewMode == ViewMode.relationMode
                ? null
                : _switchViewMode(),
          ),
        ),
      ],
    );
  }

  Widget _workBenchController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tooltip(
          message: '浏览区',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon: isBrowserPaneVisible ? browserPaneBtnActive : browserPaneBtn,
            onPressed: () => _swichBrowserPane(),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Tooltip(
          message: '编辑区',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon: isEditorPaneVisible ? editorPaneBtnActive : editorPaneBtn,
            onPressed: () => _switchEditorPane(),
          ),
        ),
      ],
    );
  }

  Widget _functionBtnGroupBuilder() {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: _browserModeBtnBuilder(),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: _workBenchController(),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _classManagerBuilder() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListView.builder(
        itemCount: classDataList.length,
        itemBuilder: (BuildContext context, int index) => ClassManagerTile(
          classData: classDataList[index],
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
          child: LayoutBuilder(
            builder: (context, constraints) => RelationChart(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
          child: Row(
            children: [
              Visibility(
                visible: isBrowserPaneVisible,
                child: Expanded(
                  flex: 1,
                  child: _classManagerBuilder(),
                ),
              ),
              Expanded(
                flex: centerFlexWeight,
                child: Column(
                  children: [
                    _functionBtnGroupBuilder(),
                    _relationChartBuilder(),
                  ],
                ),
              ),
              Visibility(
                visible: isEditorPaneVisible,
                child: Expanded(
                  flex: 1,
                  child: _editorBuilder(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const classViewBtn = Icon(
  FluentIcons.branch_commit,
  size: 20,
);
final classViewBtnActive = Icon(
  FluentIcons.branch_commit,
  color: Colors.blue,
  size: 20,
);
const relationViewBtn = Icon(
  FluentIcons.branch_fork2,
  size: 20,
);
final relationViewBtnActive = Icon(
  FluentIcons.branch_fork2,
  color: Colors.blue,
  size: 20,
);
const browserPaneBtn = Icon(
  FluentIcons.open_pane,
  size: 20,
);
final browserPaneBtnActive = Icon(
  FluentIcons.open_pane,
  color: Colors.blue,
  size: 20,
);
const editorPaneBtn = Icon(
  FluentIcons.open_pane_mirrored,
  size: 20,
);
final editorPaneBtnActive = Icon(
  FluentIcons.open_pane_mirrored,
  color: Colors.blue,
  size: 20,
);
