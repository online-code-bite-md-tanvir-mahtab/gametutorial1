import 'package:brick_brocker/src/brick_bracker.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBracker bracker;

  @override
  void initState() {
    super.initState();
    bracker = BrickBracker();
  }

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ValueListenableBuilder<int>(
                  valueListenable: bracker.score,
                  builder: (context, value, child) => Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
