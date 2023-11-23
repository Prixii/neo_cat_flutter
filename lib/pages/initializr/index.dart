import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/editor.dart';

import '../../components/initializr/preview.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class InitializrPage extends StatefulWidget {
  const InitializrPage({super.key});

  @override
  State<InitializrPage> createState() => _InitializrPageState();
}

class _InitializrPageState extends State<InitializrPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _editorBuilder() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 6, 0),
      child: TripletEditor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: FluentTheme.of(Navigator.of(context).context)
            .scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Center(
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Preview(),
                ),
                Expanded(
                  flex: 1,
                  child: _editorBuilder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
