import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/relation_browser_bloc/state.dart';

class RelationBrowserBloc
    extends Bloc<RelationBrowserEvent, RelationBrowserState> {
  RelationBrowserBloc() : super(RelationBrowserState.initial()) {
    on<InitRelationBrowserState>(
        (event, emit) => emit(_handleInitState(event)));
    on<UpdateRelation>((event, emit) => emit(_handleUpdateRelation(event)));
    on<DeleteRelation>((event, emit) => emit(_handleDeleteRelation(event)));
  }

  RelationBrowserState _handleInitState(InitRelationBrowserState event) {
    return RelationBrowserState.fromModel(event.model);
  }

  RelationBrowserState _handleUpdateRelation(UpdateRelation event) {
    var relationMap = state.relationMap;
    relationMap[event.relation.id] = event.relation;
    return state.copyWith(relationMap: relationMap);
  }

  RelationBrowserState _handleDeleteRelation(DeleteRelation event) {
    return state.copyWith(
        relationMap: state.relationMap..remove(event.targetId));
  }
}
