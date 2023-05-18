import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';

/// A weapon can be equipped to a [Robot] and used to fight, or
/// to affect the environment. Some weapons have instantaneous
/// effect, and some create a [Projectile] when they fire,
/// produces its own effect.
abstract class Weapon extends Component with ParentIsA<Robot> {
  int get ammunition;

  bool get canFire;

  void fire();
}
