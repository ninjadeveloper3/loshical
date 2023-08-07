import 'package:flutter/material.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/hugged_child.dart';

class AnswerImage extends StatelessWidget {
  final int index;
  const AnswerImage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: index,
      feedback:
          HuggedChild(child: Image.asset(AssetManager.answerPaths[index])),
      childWhenDragging: Container(),
      onDragEnd: (details) {},
      child: HuggedChild(child: Image.asset(AssetManager.answerPaths[index])),
    );
  }
}
