import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/pages/hello/index.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

import 'bloc/class_browser_bloc/bloc.dart';
import 'bloc/relation_browser_bloc/bloc.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final relationChartDataBloc = RelationChartDataBloc();
    return BlocProvider(
      create: (context) => relationChartDataBloc,
      child: BlocProvider(
        create: (context) => TripletEditorBloc(dataBloc: relationChartDataBloc),
        child: BlocProvider<ClassBrowserBloc>(
          create: (context) => ClassBrowserBloc(),
          child: BlocProvider<RelationBrowserBloc>(
            create: (context) => RelationBrowserBloc(),
            child: FluentApp(
              theme: lightTheme,
              home: const HelloPage(),
            ),
          ),
        ),
      ),
    );
  }
}
