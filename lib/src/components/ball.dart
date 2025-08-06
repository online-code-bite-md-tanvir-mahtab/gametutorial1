import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:brick_brocker/src/components/play_area.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent with CollisionCallbacks, HasGameReference<BrickBracker> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
         radius: radius,
         anchor: Anchor.center,
         paint: Paint()
           ..color = const Color(0xff1e6091)
           ..style = PaintingStyle.fill,
          children: [
            CircleHitbox(),
          ],
       );

  final Vector2 velocity;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    print("Ball position: $position, velocity: $velocity dt: $dt");
    position += velocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        // it should bounce back to other derection
        velocity.x = -velocity.x;
      } 
    } else {
      debugPrint('collision with $other');
    }
  }
}
