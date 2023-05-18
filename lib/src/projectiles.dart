import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';

/// A projectile is produced when certain weapons fire. It has
/// a range and type of effect, depending on its implementation.
/// It is a child of the [Robot] whose weapon produced it.
class Projectile extends Component with ParentIsA<Robot> {}
