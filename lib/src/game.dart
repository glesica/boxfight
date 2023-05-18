import 'package:boxfight/src/grid.dart';
import 'package:flame/game.dart';

class BoxFight extends FlameGame {
  @override
  Future<void> onLoad() async {
    await add(Grid(height: 30, width: 50));
  }
}
