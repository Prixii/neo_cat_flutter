import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/main_navigator.dart';

import '../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-30 21

class CreateProjectCard extends StatefulWidget {
  const CreateProjectCard({super.key});

  @override
  State<CreateProjectCard> createState() => _CreateProjectCardState();
}

class _CreateProjectCardState extends State<CreateProjectCard> {
  var blurRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    void toInitializr() {
      Navigator.push(
        context,
        FluentPageRoute(
          builder: (context) => const MainNavigator(),
        ),
      );
    }

    return Expanded(
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
          onTap: () => toInitializr(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create',
                  style: defaultTextBlack.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
