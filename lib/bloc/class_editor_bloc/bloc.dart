import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/class_editor_bloc/state.dart';

class ClassEditorBloc extends Bloc<ClassEditorEvent, ClassEditorState> {
  ClassEditorBloc() : super(ClassEditorState.initial()) {
    on<ChooseClass>((event, emit) => emit(_handleChooseClass(event)));
  }

  ClassEditorState _handleChooseClass(ChooseClass event) {
    return state.copyWith(classData: event.classData);
  }
}
