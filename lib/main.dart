import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = BrickBracker();
  runApp(GameWidget(game: game));
}

