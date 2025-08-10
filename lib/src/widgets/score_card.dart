import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.score});

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: score,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'Score: $value',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      },
    );
  }
}
