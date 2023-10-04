import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/manager_view_mode.dart';

class FunctionButtonGroup extends StatefulWidget {
  const FunctionButtonGroup({super.key});

  @override
  State<FunctionButtonGroup> createState() => _FunctionButtonGroupState();
}

class _FunctionButtonGroupState extends State<FunctionButtonGroup> {
  var currentViewMode = ViewMode.classMode;

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

  Widget _modeBtnBuilder() {
    return Row(
      children: [
        Tooltip(
          message: '类视图',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon: const Icon(
              FluentIcons.branch_commit,
              size: 20,
            ),
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
            icon: const Icon(
              FluentIcons.branch_fork2,
              size: 20,
            ),
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
            icon: const Icon(
              FluentIcons.open_pane,
              size: 20,
            ),
            onPressed: () => currentViewMode == ViewMode.classMode
                ? null
                : _switchViewMode(),
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
            icon: const Icon(
              FluentIcons.open_pane_mirrored,
              size: 20,
            ),
            onPressed: () => currentViewMode == ViewMode.relationMode
                ? null
                : _switchViewMode(),
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
