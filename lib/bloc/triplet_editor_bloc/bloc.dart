import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';

class TripletEditorBloc extends Bloc<TripletEditorEvent, TripletEditorState> {
  TripletEditorBloc() : super(TripletEditorState.initial()) {}
}
