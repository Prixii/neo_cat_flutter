import 'package:neo_cat_flutter/types/enums.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

abstract class WidgetControllerEvent {
  WidgetControllerEvent();
}

/// 设置viewMode到 [viewMode]
class SetViewMode extends WidgetControllerEvent {
  final ViewMode viewMode;

  SetViewMode({required this.viewMode});
}

/// 设置浏览界面BrowseerPane的可见性为 [isVisible]
class SetIsBrowserPaneVisible extends WidgetControllerEvent {
  final bool isVisible;

  SetIsBrowserPaneVisible({required this.isVisible});
}

/// 设置编辑界面EditorPane的可见性为 [isVisible]
class SetIsEditorPaneVisible extends WidgetControllerEvent {
  final bool isVisible;

  SetIsEditorPaneVisible({required this.isVisible});
}
