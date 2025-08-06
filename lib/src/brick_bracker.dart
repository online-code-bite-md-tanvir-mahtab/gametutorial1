import 'dart:async';
import 'dart:math';
import 'dart:math' as math;

import 'package:brick_brocker/src/components/ball.dart';
import 'package:brick_brocker/src/components/play_area.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'config.dart';

class BrickBracker extends FlameGame with HasCollisionDetection {
  // creating constructor
  BrickBracker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
    world.add(
      Ball(
        // Add from here...
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()..scale(height / 10),
      ),
    );
  }
}
