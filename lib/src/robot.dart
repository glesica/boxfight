import 'package:boxfight/src/cell.dart';
import 'package:boxfight/src/drivers.dart';
import 'package:boxfight/src/heading.dart';
import 'package:boxfight/src/sensors.dart';
import 'package:boxfight/src/styles.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

mixin RobotAttributes {
  double armor = 0.0;

  Heading facing = Heading.north;

  int speed = 1;
}

class Robot extends Component with ParentIsA<Cell> {
  // TODO: Consider making attributes classes into components
  final RobotAttributes attributes;

  Robot({
    required this.attributes,
    super.children,
    super.priority,
  }) {
    add(DummyDriver());

    add(DirectionalSensor());

    add(TurretStyle(
      primary: Paint()..color = Colors.pink,
      secondary: Paint()..color = Colors.lightGreen,
      tertiary: Paint()..color = Colors.blueGrey,
    ));
  }

  Cell get forward => parent.cellToward(attributes.facing);

  Cell get rightward => parent.cellToward(attributes.facing.right);

  Cell get backward => parent.cellToward(attributes.facing.backward);

  Cell get leftward => parent.cellToward(attributes.facing.left);

  @override
  void onLoad() {
    children.register<Sensor>();
  }

  @override
  void update(double dt) {}
}
