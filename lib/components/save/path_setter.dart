import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class PathSetter extends StatefulWidget {
  const PathSetter({super.key});

  @override
  State<PathSetter> createState() => _PathSetterState();
}

class _PathSetterState extends State<PathSetter> {
  late TextEditingController _folderNameController;
  late TextEditingController _fileNameController;

  @override
  void initState() {
    super.initState();
    _folderNameController = TextEditingController();
    _fileNameController = TextEditingController();
  }

  @override
  void dispose() {
    _folderNameController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }

  Widget _titleBuilder() {
    return Text(
      'Save',
      style: defaultTextBlack.copyWith(fontSize: 24),
    );
  }

  Widget _foldSelectorBuilder() {
    return Row(
      children: [
        Text(
          'Folder: ',
          style: defaultTextBlack,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextBox(
            controller: _folderNameController,
          ),
        ),
        const SizedBox(width: 20),
        FilledButton(
          child: const Icon(
            FluentIcons.more,
            size: 16,
          ),
          onPressed: () async {
            _folderNameController.text = await pickFolderPath() ?? '';
          },
        )
      ],
    );
  }

  Widget _fileNameSetterBuilder() {
    return Row(
      children: [
        Text(
          'Name : ',
          style: defaultTextBlack,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextBox(
            controller: _fileNameController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            '.json',
            style: defaultText.copyWith(color: Colors.grey[70]),
          ),
        ),
      ],
    );
  }

  Widget _buttonBuilder() {
    return SizedBox(
      height: 60,
      child: Center(
        child: FilledButton(
          child: const Text(
            'Save',
            style: defaultText,
          ),
          onPressed: () => {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 450,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _titleBuilder(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _foldSelectorBuilder(),
                      const SizedBox(height: 20),
                      _fileNameSetterBuilder(),
                    ],
                  ),
                ),
                _buttonBuilder(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
