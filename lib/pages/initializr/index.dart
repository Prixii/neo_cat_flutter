import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/pages/hello/index.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class InitializrPage extends StatefulWidget {
  const InitializrPage({super.key});

  @override
  State<InitializrPage> createState() => _InitializrPageState();
}

class _InitializrPageState extends State<InitializrPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Container(
        color: FluentTheme.of(Navigator.of(context).context)
            .scaffoldBackgroundColor,
        child: Center(
          child: Column(
            children: [
              const Text('Here is initializr'),
              Button(
                  child: const Text('backToHello'),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            FluentPageRoute(
                                builder: (context) => const HelloPage()))
                      })
            ],
          ),
        ),
      ),
    );
  }
}
