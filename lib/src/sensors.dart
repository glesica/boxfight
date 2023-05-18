import 'package:boxfight/src/cell.dart';
import 'package:boxfight/src/heading.dart';
import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';

/// A serializable [Robot] model that is used to communicate
/// state to a driver, as part of a [CellState] object.
///
/// TODO: Consider replacing this with an attributes interface
/// This way we'd be able to simply pass the Robot itself along
/// to the driver in a polymorphic manner.
class RobotState {
  RobotState.fromRobot(Robot robot) {}
}

/// A serializable [Cell] model that is used to communicate state
/// to a driver. It can contain incomplete information, based on
/// the capabilities of the [Sensor] that produced it. This way
/// we have clean separation between the code that will eventually
/// be supplied by players, and the internal logic.
///
/// TODO: Update to contain properties of the cell, not just robots
class CellState {
  Direction? direction;

  CellState.fromCell(Cell cell) {}
}

class SensorOutput {
  final CellState cell;
  final Iterable<RobotState> robots;

  SensorOutput({
    required this.cell,
    required this.robots,
  });
}

abstract class Sensor extends Component with ParentIsA<Robot> {
  /// Assemble the relevant cell and robot states into an iterable
  /// of sensor outputs. The default implementation should be
  /// sufficient for most sensor types.
  Iterable<SensorOutput> detect() {
    return cellsInRange().map((c) => SensorOutput(
      cell: scanCell(c),
      robots: c.robots.map(scanRobot),
    ));
  }

  /// Collect the cell(s) within range of the sensor so that data
  /// can be extracted from them.
  Iterable<Cell> cellsInRange();

  /// Extract information from the given cell in a way that
  /// reflects the capabilities and accuracy of the sensor.
  CellState scanCell(Cell cell);

  /// Extract robot information from the in a way that
  /// reflects the capabilities and accuracy of the sensor.
  RobotState scanRobot(Robot robot);
}

/// A simple sensor that provides information on robots present
/// in an adjacent cell.
///
/// TODO: Allow the sensor to point left, right, or backward
/// TODO: Allow range to be greater than 1
class DirectionalSensor extends Sensor {
  @override
  Iterable<Cell> cellsInRange() {
    return [parent.forward];
  }

  @override
  CellState scanCell(Cell cell) {
    return CellState.fromCell(cell);
  }

  @override
  RobotState scanRobot(Robot robot) {
    return RobotState.fromRobot(robot);
  }
}
