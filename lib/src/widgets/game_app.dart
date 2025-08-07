import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffa9d6e5), Color(0xfff2e8cf)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: FittedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GameWidget.controlled(
                    gameFactory: BrickBracker.new,
                    overlayBuilderMap: {
                      PlayState.welcome.name: (context, game) => Center(
                        child: Text(
                          'TAP TO PLAY',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      PlayState.gameOver.name: (context, game) => Center(
                        child: Text(
                          'G A M E   O V E R',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      PlayState.won.name: (context, game) => Center(
                        child: Text(
                          'Y O U   W O N ! ! !',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}