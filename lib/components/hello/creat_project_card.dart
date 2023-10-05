import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/main_navigator.dart';

/// @author wang.jiaqi
/// @date 2023-09-30 21

class CreateProjectCard extends StatelessWidget {
  const CreateProjectCard({super.key});

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
      child: GestureDetector(
        onTap: () => toInitializr(),
        child: Container(
          color: Colors.blue,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create'),
            ],
          ),
        ),
      ),
    );
  }
}
