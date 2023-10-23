import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/widget_controller_bloc/state.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/label_manager.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/edge_manager.dart';
import 'package:neo_cat_flutter/types/enums.dart';

class BrowserPane extends StatefulWidget {
  const BrowserPane({super.key});

  @override
  State<BrowserPane> createState() => _BrowserPaneState();
}

class _BrowserPaneState extends State<BrowserPane> {
  WidgetControllerState _getBlocState() =>
      context.read<WidgetControllerBloc>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetControllerBloc, WidgetControllerState>(
      builder: (context, state) => Stack(
        children: [
          Visibility(
            visible: _getBlocState().viewMode == ViewMode.classMode,
            child: const ClassManager(),
          ),
          Visibility(
            visible: _getBlocState().viewMode == ViewMode.relationMode,
            child: const RelationManager(),
          )
        ],
      ),
    );
  }
}
