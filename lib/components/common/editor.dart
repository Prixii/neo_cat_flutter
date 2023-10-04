import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/common/attr_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

class TripletEditor extends StatefulWidget {
  const TripletEditor({super.key});

  @override
  State<TripletEditor> createState() => _TripletEditorState();
}

class _TripletEditorState extends State<TripletEditor> {
  Widget _tripletEditorBuilder() {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: CirclePainter(),
                      );
                    },
                  ),
                  const Center(
                    child: Text('name'),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: ArrowPainter(),
                        );
                      },
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('relation'),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: CirclePainter(),
                      );
                    },
                  ),
                  const Center(
                    child: Text('name'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attrListBuilder() {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return const AttributeTile();
        });
  }

  Widget _confirmBtnBuilder() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Button(
            child: const Center(
              child: Text(
                'confirm',
              ),
            ),
            onPressed: () => {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tripletEditorBuilder(),
        const Divider(),
        Expanded(
          child: Container(
            decoration: normalBoxDecoration,
            child: _attrListBuilder(),
          ),
        ),
        _confirmBtnBuilder(),
        const Divider(),
      ],
    );
  }
}
