import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/save/path_setter.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  // TODO Cubit
  @override
  Widget build(BuildContext context) {
    return const PathSetter();
  }
}
