import 'package:neo_cat_flutter/types/enums.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class WidgetControllerState {
  final ViewMode viewMode;
  final bool isBrowserPaneVisible;
  final bool isEditorPaneVisible;

  WidgetControllerState({
    required this.viewMode,
    required this.isBrowserPaneVisible,
    required this.isEditorPaneVisible,
  });

  WidgetControllerState.initial()
      : viewMode = ViewMode.classMode,
        isBrowserPaneVisible = true,
        isEditorPaneVisible = true;

  WidgetControllerState copyWith({
    ViewMode? viewMode,
    bool? isBrowserPaneVisible,
    bool? isEditorPaneVisible,
  }) =>
      WidgetControllerState(
        viewMode: viewMode ?? this.viewMode,
        isBrowserPaneVisible: isBrowserPaneVisible ?? this.isBrowserPaneVisible,
        isEditorPaneVisible: isEditorPaneVisible ?? this.isEditorPaneVisible,
      );
}
