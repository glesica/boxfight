import 'package:boxfight/src/cell.dart';
import 'package:boxfight/src/heading.dart';
import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// A style that can be applied to a robot. This class, and
/// its descendants, are generally responsible for drawing
/// the robots on the screen.
abstract class RobotStyle extends Component with ParentIsA<Robot> {
  final Paint primary;
  final Paint secondary;
  final Paint tertiary;

  RobotStyle({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  Vector2 get center => parent.parent.center;
}

/// A robot that is rendered to look a bit like a turret with
/// a base and a gun that points in the direction of fire.
class TurretStyle extends RobotStyle {
  TurretStyle({
    required super.primary,
    required super.secondary,
    required super.tertiary,
  });

  Offset get gunOffset => switch (parent.attributes.facing) {
      Heading.north => const Offset(0, Cell.baseSize),
      Heading.east => const Offset(Cell.baseSize, 0),
      Heading.south => const Offset(0, -Cell.baseSize),
      Heading.west => const Offset(-Cell.baseSize, 0),
    };

  @override
  void render(Canvas canvas) {
    final centerOffset = center.toOffset();
    canvas.drawCircle(centerOffset, Cell.baseSize / 3, primary);
    canvas.drawLine(centerOffset, centerOffset + gunOffset, secondary);
    canvas.drawCircle(centerOffset, Cell.baseSize / 7, tertiary);
  }
}
