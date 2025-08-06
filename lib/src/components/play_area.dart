
import 'dart:async';

import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickBracker> {
  PlayArea(): super(
    paint: Paint()..color = const Color(0xfff2e8cf),
  );

  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad
    super.onLoad();
    size= Vector2(game.width, game.height);
  }
}