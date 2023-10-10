import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/types/node.dart';

import '../bloc/relation_chart_data_bloc/bloc.dart';

Future<List<BaseNode>> getNodesByClass(
    {required BuildContext context, required String className}) async {
  List<BaseNode> nodeList =
      context.read<RelationChartDataBloc>().state.relationChartData.nodeList;
  List<BaseNode> resultList = [];
  for (var node in nodeList) {
    if (node.className == className) {
      resultList.add(node);
    }
  }
  return resultList;
}
