import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/types/relation.dart';

import 'node.dart';

typedef Position = (double, double);

typedef NodeId = int;

typedef RelationId = int;

typedef LabelName = String;

typedef Triplet = (Node, Relation, Node);

typedef RelationChartDataBlocGetter = RelationChartDataBloc Function();
