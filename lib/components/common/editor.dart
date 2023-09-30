import 'package:fluent_ui/fluent_ui.dart';

class TripletEditor extends StatefulWidget {
  const TripletEditor({super.key});

  @override
  State<TripletEditor> createState() => _TripletEditorState();
}

class _TripletEditorState extends State<TripletEditor> {
  Widget _tripletViewerBuilder() {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              color: Colors.black,
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _confirmBtnBuilder() {
    return SizedBox(
      height: 80,
      child: Container(color: Colors.purple),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tripletViewerBuilder(),
        Divider(),
        Expanded(
          child: Container(
            color: Colors.green,
          ),
        ),
        _confirmBtnBuilder()
      ],
    );
  }
}
