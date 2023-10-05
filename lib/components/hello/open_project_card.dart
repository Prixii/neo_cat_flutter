import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/main_navigator.dart';

import '../../utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-30 21

class OpenProjectCard extends StatelessWidget {
  const OpenProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    void toInitializr(String? rawData) {
      Navigator.push(
        context,
        // FluentPageRoute(
        //   builder: (context) => InitializrPage(
        //     rawData: rawData,
        //   ),
        // ),
        FluentPageRoute(builder: (context) => const MainNavigator()),
      );
    }

    Future<void> handleOpenFile() async {
      String? filePath = await openFile(['json']);
      if (filePath != null) {
        String? content = await readFile(filePath);
        logger.d('[content] $content');
        if (content != null) {
          final rawData = await readFile(filePath);
          toInitializr(rawData);
        }
      }
    }

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => handleOpenFile(),
        child: Container(
          color: Colors.blue,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Open'),
            ],
          ),
        ),
      ),
    );
  }
}
