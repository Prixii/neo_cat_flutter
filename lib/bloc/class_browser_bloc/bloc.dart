import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/state.dart';

class ClassBrowserBloc extends Bloc<ClassBrowserEvent, ClassBrowserState> {
  ClassBrowserBloc() : super(ClassBrowserState.initial()) {}
}
