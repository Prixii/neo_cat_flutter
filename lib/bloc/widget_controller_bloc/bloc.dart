import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/state.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class WidgetControllerBloc
    extends Bloc<WidgetControllerEvent, WidgetControllerState> {
  WidgetControllerBloc() : super(WidgetControllerState.initial()) {}
}
