import 'package:fluent_ui/fluent_ui.dart';

class RichTextEditingController extends TextEditingController {
  BuildContext context;

  RichTextEditingController({required this.context});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return TextSpan(text: text);
  }
}
