import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:brick_brocker/src/components/ball.dart';
import 'package:brick_brocker/src/components/bat.dart';
import 'package:brick_brocker/src/components/brick.dart';
import 'package:brick_brocker/src/components/play_area.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'config.dart';

enum PlayState { welcome, playing, gameOver, won }

class BrickBracker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
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
  final ValueNotifier<int> score = ValueNotifier<int>(0);

  late PlayState _playState; // Add from here...
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    score.value = 0; // Reset score
    // if (playState == PlayState.welcome) {
    //   playState = PlayState.playing;
    // } else if (playState == PlayState.gameOver || playState == PlayState.won) {
    //   world.removeAll(world.children.query<Ball>());
    //   world.removeAll(world.children.query<Bat>());
    //   world.removeAll(world.children.query<Brick>());
    //   onLoad();
    // }
    if (playState == PlayState.playing) return;
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.playing;

    world.add(
      Ball(
        defecultModifier: difficultyModifier,
        // Add from here...
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()..scale(height / 3),
      ),
    );

    // now going to add the bat to the world
    world.add(
      Bat(
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
        size: Vector2(batWidth, batHeight),
      ),
    );
    // create empty list of brick colors
    final bricks = <Brick> [
    ];

    for (var i = 0; i < brickColors.length; i++) {
      for (var j = 1; j <= 5; j++) {
        bricks.add(
          Brick(
            position: Vector2(
              brickWidth * (i + 0.5) + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
        );
      }
    }

    // now i am going to add the brick to the world
    world.addAll(bricks);
  }

  @override
  void onTap() {
    // TODO: implement onTap
    super.onTap();
    startGame();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // TODO: implement onKeyEvent
    super.onKeyEvent(event, keysPressed);
    // in here add the drag logic
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
      // startGame();
      case LogicalKeyboardKey.space: // Add from here...
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
