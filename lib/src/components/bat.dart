import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/rendering.dart';

class Bat extends PositionComponent with DragCallbacks, HasGameReference<BrickBracker>{
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size
  }): super (
    children: [
      RectangleHitbox(),
    ],
  );

  // declare cornerRadius variable
  final Radius cornerRadius;

  // need to add the paint
  final Paint _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    // now going to draw the bat
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),cornerRadius
      ),
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // TODO: implement onDragUpdate
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }

  void moveBy(double dx) {
    // move the bat by dx
    // position.x = (position.x + dx).clamp(0, game.width - size.x);
    add(
      MoveToEffect(
        Vector2((position.x + dx).clamp(0, game.width), position.y),
        EffectController(duration: 0.1),
      ),
    );
  }

}