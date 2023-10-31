import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_editing_controller.dart';

class GlobalData {
  RichTextEditingController richTextEditingController;

  GlobalData({required BuildContext context})
      : richTextEditingController = RichTextEditingController(context: context);
}

late GlobalData globalData;
