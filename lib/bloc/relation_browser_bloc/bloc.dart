import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/state.dart';

class RelationBrowserBloc
    extends Bloc<RelationBrowserEvent, RelationBrowserState> {
  RelationBrowserBloc() : super(RelationBrowserState.initial()) {}
}
