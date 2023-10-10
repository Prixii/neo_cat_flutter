import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class TripletTile extends StatefulWidget {
  const TripletTile({super.key});

  @override
  State<TripletTile> createState() => _TripletTileState();
}

class _TripletTileState extends State<TripletTile> {
  @override
  Widget build(BuildContext context) {
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
}
