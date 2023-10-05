import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/manager_view_mode.dart';

class FunctionButtonGroup extends StatefulWidget {
  const FunctionButtonGroup({super.key});

  @override
  State<FunctionButtonGroup> createState() => _FunctionButtonGroupState();
}

class _FunctionButtonGroupState extends State<FunctionButtonGroup> {
  final classViewBtn = const Icon(
    FluentIcons.branch_commit,
    size: 20,
  );
  final classViewBtnActive = Icon(
    FluentIcons.branch_commit,
    color: Colors.blue,
    size: 20,
  );
  final relationViewBtn = const Icon(
    FluentIcons.branch_fork2,
    size: 20,
  );
  final relationViewBtnActive = Icon(
    FluentIcons.branch_fork2,
    color: Colors.blue,
    size: 20,
  );
  final browserPaneBtn = const Icon(
    FluentIcons.open_pane,
    size: 20,
  );
  final browserPaneBtnActive = Icon(
    FluentIcons.open_pane,
    color: Colors.blue,
    size: 20,
  );
  final editorPaneBtn = const Icon(
    FluentIcons.open_pane_mirrored,
    size: 20,
  );
  final editorPaneBtnActive = Icon(
    FluentIcons.open_pane_mirrored,
    color: Colors.blue,
    size: 20,
  );

  var currentViewMode = ViewMode.classMode;
  var showBrowserPane = true;
  var showEditorPane = true;

  void _switchViewMode() {
    switch (currentViewMode) {
      case ViewMode.classMode:
        {
          setState(
            () {
              currentViewMode = ViewMode.relationMode;
            },
          );
          break;
        }
      case ViewMode.relationMode:
        {
          setState(
            () {
              currentViewMode = ViewMode.classMode;
            },
          );
          break;
        }
    }
  }

  void _swichBrowserPane() {
    setState(() {
      showBrowserPane = !showBrowserPane;
    });
  }

  void _switchEditorPane() {
    setState(() {
      showEditorPane = !showEditorPane;
    });
  }

  Widget _modeBtnBuilder() {
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
            icon: showBrowserPane ? browserPaneBtnActive : browserPaneBtn,
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
            icon: showEditorPane ? editorPaneBtnActive : editorPaneBtn,
            onPressed: () => _switchEditorPane(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: _modeBtnBuilder(),
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
}
