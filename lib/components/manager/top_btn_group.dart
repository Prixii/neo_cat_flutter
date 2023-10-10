import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/event.dart';
import 'package:neo_cat_flutter/types/enums.dart';

class TopBtnGroup extends StatefulWidget {
  const TopBtnGroup({super.key});

  @override
  State<TopBtnGroup> createState() => _TopBtnGroupState();
}

class _TopBtnGroupState extends State<TopBtnGroup> {
  @override
  void initState() {
    super.initState();
  }

  void _switchViewMode(ViewMode viewMode) {
    _getWidgetControllerBloc().add(SetViewMode(viewMode: viewMode));
  }

  WidgetControllerBloc _getWidgetControllerBloc() =>
      context.read<WidgetControllerBloc>();

  Widget _browserModeBtnBuilder() {
    return Row(
      children: [
        Tooltip(
          message: '类视图',
          displayHorizontally: true,
          useMousePosition: false,
          style: const TooltipThemeData(preferBelow: true),
          child: IconButton(
            icon:
                _getWidgetControllerBloc().state.viewMode == ViewMode.classMode
                    ? classViewBtnActive
                    : classViewBtn,
            onPressed: () =>
                _getWidgetControllerBloc().state.viewMode == ViewMode.classMode
                    ? null
                    : _switchViewMode(ViewMode.classMode),
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
            icon: _getWidgetControllerBloc().state.viewMode ==
                    ViewMode.relationMode
                ? relationViewBtnActive
                : relationViewBtn,
            onPressed: () => _getWidgetControllerBloc().state.viewMode ==
                    ViewMode.relationMode
                ? null
                : _switchViewMode(ViewMode.relationMode),
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
            icon: _getWidgetControllerBloc().state.isBrowserPaneVisible
                ? browserPaneBtnActive
                : browserPaneBtn,
            onPressed: () =>
                _getWidgetControllerBloc().add(SetIsBrowserPaneVisible()),
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
            icon: _getWidgetControllerBloc().state.isEditorPaneVisible
                ? editorPaneBtnActive
                : editorPaneBtn,
            onPressed: () =>
                _getWidgetControllerBloc().add(SetIsEditorPaneVisible()),
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
