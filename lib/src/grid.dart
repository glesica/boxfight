import 'dart:async';

import 'package:boxfight/src/cell.dart';
import 'package:boxfight/src/game.dart';
import 'package:boxfight/src/heading.dart';
import 'package:flame/components.dart';

// TODO: Support loading maps here, starting states for cells

/// A game grid of a given height and width.
///
/// The grid origin is in the upper-left and indices begin at 0.
class Grid extends Component with ParentIsA<BoxFight> {
  final int height;
  final int width;

  // Internal index of children, the first key is the column,
  // and the second key is the row.
  final Map<int, Map<int, Cell>> _cellIndex = {};

  static int _wrap(int value, int size) {
    return (value + size) % size;
  }

  Grid({
    required this.height,
    required this.width,
  }) {
    children.register<Cell>();
  }

  Cell _cellAt(int col, int row) {
    return _cellIndex[col]![row]!;
  }

  int _wrapCol(int col) {
    return _wrap(col, width);
  }

  int _wrapRow(int row) {
    return _wrap(row, height);
  }

  // Iterable<Cell> cellsNear(Cell cell) {}

  /// Return the cell nearest this one on the given heading.
  Cell cellToward(Cell cell, Heading heading) {
    int col = cell.column;
    int row = cell.row;
    switch (heading) {
      case Heading.north:
        row = _wrapRow(row - 1);
      case Heading.east:
        col = _wrapCol(col + 1);
      case Heading.south:
        row = _wrapRow(row + 1);
      case Heading.west:
        col = _wrapCol(col - 1);
    }

    return _cellAt(col, row);
  }

  @override
  FutureOr<void> onLoad() async {
    // Construct the cells contained within the grid
    for (final c in List.generate(width, (index) => index)) {
      _cellIndex[c] = {};
      for (final r in List.generate(height, (index) => index)) {
        final cell = Cell(attributes: CellAttributes(), row: r, column: c);
        _cellIndex[c]![r] = cell;
        await add(cell);
      }
    }
  }
}
