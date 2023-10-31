import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/pages/main_navigator.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';

import '../../bloc/relation_chart_data_bloc/event.dart';
import '../../theme/common_theme.dart';
import '../../utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-30 21
class OpenProjectCard extends StatefulWidget {
  const OpenProjectCard({super.key});

  @override
  State<OpenProjectCard> createState() => _OpenProjectCardState();
}

class _OpenProjectCardState extends State<OpenProjectCard> {
  var blurRadius = 10.0;
  var bgColor = Colors.white.withOpacity(0.95);
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    void initStateAndJump(String rawData) {
      setState(() {
        isLoading = true;
        bgColor = Colors.grey.withOpacity(0.6);
      });
      if (context.mounted) {
        relationChartDataBloc(context).add(
          InitRelationChartData(rawData: rawData),
        );
      }
    }

    Future<void> handleOpenFile() async {
      String? filePath = await pickFileAndGetPath(['json']);
      if (filePath != null) {
        String? content = await readFile(filePath);
        if (content != null) {
          final rawData = await readFile(filePath);
          if (rawData != null) {
            if (context.mounted) {
              initStateAndJump(rawData);
            }
          }
        }
      }
    }

    void toInitializr() {
      Navigator.push(
        context,
        FluentPageRoute(
          builder: (context) => const MainNavigator(),
        ),
      );
    }

    return BlocListener<RelationChartDataBloc, RelationChartDataState>(
      listenWhen: (previous, current) =>
          previous.isInitDone != current.isInitDone,
      listener: (context, state) {
        if (state.isInitDone == true) {
          customDisplayInfoBar(
            context: context,
            title: '喜报',
            content: '解析成功',
            severity: InfoBarSeverity.success,
          );
          toInitializr();
        }
      },
      child: Expanded(
        flex: 1,
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              blurRadius = 20;
            });
          },
          onExit: (event) {
            setState(() {
              blurRadius = 10;
            });
          },
          child: GestureDetector(
            onTap: () => handleOpenFile(),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: blurRadius,
                    )
                  ]),
              child: Center(
                child: Stack(
                  children: [
                    Text(
                      'Open',
                      style: defaultTextBlack.copyWith(fontSize: 18),
                    ),
                    Visibility(
                      visible: isLoading,
                      child: const ProgressRing(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
