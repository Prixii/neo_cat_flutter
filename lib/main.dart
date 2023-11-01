import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/global_data.dart';
import 'package:neo_cat_flutter/pages/hello/index.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(effect: WindowEffect.acrylic);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    globalData = GlobalData(context: context);
    final relationChartDataBloc = RelationChartDataBloc();
    return BlocProvider(
      create: (context) => relationChartDataBloc,
      child: BlocProvider(
        create: (context) => TripletEditorBloc(dataBloc: relationChartDataBloc),
        child: FluentApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: const Acrylic(
            child: HelloPage(),
          ),
        ),
      ),
    );
  }
}
