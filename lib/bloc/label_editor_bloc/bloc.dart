import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/label_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/label_editor_bloc/state.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class ClassEditorBloc extends Bloc<ClassEditorEvent, ClassEditorState> {
  ClassEditorBloc() : super(ClassEditorState.initial()) {
    on<ChooseClass>((event, emit) => emit(_handleChooseClass(event)));
  }

  ClassEditorState _handleChooseClass(ChooseClass event) {
    logger.i('[classEditor]: ChooseClass!');
    return state.copyWith(classData: event.classData);
  }
}
