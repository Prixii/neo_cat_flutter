import 'package:fluent_ui/fluent_ui.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.yellow,
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
          ),
          flex: 3,
        ),
      ],
    );
  }
}
