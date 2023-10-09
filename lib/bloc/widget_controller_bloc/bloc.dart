import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/state.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class WidgetControllerBloc
    extends Bloc<WidgetControllerEvent, WidgetControllerState> {
  WidgetControllerBloc() : super(WidgetControllerState.initial()) {
    on<SetViewMode>((event, emit) => emit(_handleSetViewMode(event)));
    on<SetIsBrowserPaneVisible>(
        (event, emit) => emit(_handleSetIsBrowserVisible(event)));
    on<SetIsEditorPaneVisible>(
        (event, emit) => emit(_handleSetIsEditorVisible(event)));
  }

  WidgetControllerState _handleSetViewMode(SetViewMode event) {
    return state.copyWith(viewMode: event.viewMode);
  }

  WidgetControllerState _handleSetIsBrowserVisible(
      SetIsBrowserPaneVisible event) {
    return state.copyWith(isBrowserPaneVisible: event.isVisible);
  }

  WidgetControllerState _handleSetIsEditorVisible(
      SetIsEditorPaneVisible event) {
    return state.copyWith(isEditorPaneVisible: event.isVisible);
  }
}
