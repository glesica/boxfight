import 'package:boxfight/src/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

void main() {
  final game = BoxFight();

  runApp(
    GameWidget(
      game: game,
    ),
  );
}
