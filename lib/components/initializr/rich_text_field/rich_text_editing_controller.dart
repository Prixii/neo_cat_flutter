import 'package:fluent_ui/fluent_ui.dart';

class RichTextEditingController extends TextEditingController {
  RichTextEditingController({required this.context});

  BuildContext context;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return TextSpan(text: text);
  }
}
