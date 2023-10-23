import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/types/source_edge.dart';

import 'source_node.dart';

typedef Position = (double, double);

typedef NodeId = int;

typedef EdgeId = int;

typedef LabelName = String;

typedef Triplet = (SourceNode, SourceEdge, SourceNode);

typedef RelationChartDataBlocGetter = RelationChartDataBloc Function();
