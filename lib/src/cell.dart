import 'dart:async';

import 'package:boxfight/src/grid.dart';
import 'package:boxfight/src/heading.dart';
import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// The type of terrain present in a given [Cell], which may
/// affect movement or other actions and events within the game.
enum Terrain {
  dirt,
  forest,
  pavement,
  water,
}

// TODO: Consider de-coupling rendering
extension Rendering on Terrain {
  Color get background => switch (this) {
        Terrain.dirt => Colors.brown,
        Terrain.forest => Colors.green,
        Terrain.pavement => Colors.grey,
        Terrain.water => Colors.blue,
      };
}

/// A model of the attributes that can be associated with a
/// single [Cell]. These are grouped together for clarity. They
/// may be accessed by sensors and other components within the
/// game in order to affect play.
class CellAttributes {
  double elevation = 0.0;

  Terrain terrain = Terrain.dirt;
}

/// A [Cell] reflects a single location within the game 2D grid
/// that comprises the game world. Cells can have attributes,
/// found in `CellAttributes` and can contain robots. Robots
/// move from cell to cell during the course of the game. The
/// actions the robots take can, in some cases, alter the
/// attributes of one or more cells.
class Cell extends RectangleComponent with ParentIsA<Grid> {
  static const baseSize = 20.0;

  final CellAttributes attributes;

  final int row;
  final int column;

  Cell({
    required this.attributes,
    required this.row,
    required this.column,
    super.children,
    super.priority,
  }) : super(
          position: Vector2(column * baseSize, row * baseSize),
          size: Vector2(baseSize, baseSize),
        );

  /// The [Robot]s present at this location.
  Iterable<Robot> get robots => children.query<Robot>();

  /// Return the Manhattan distance from this cell to the
  /// given cell (movement limited to north, south, east
  /// and west).
  int distanceTo(Cell cell) {
    return 0;
  }

  /// Return the cell in the given cardinal direction from
  /// this one.
  Cell cellToward(Heading heading) {
    return parent.cellToward(this, heading);
  }

  @override
  FutureOr<void> onLoad() async {
    children.register<Robot>();

    paint.color = attributes.terrain.background;
  }

  @override
  void update(double dt) {}
}
