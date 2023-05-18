import 'package:boxfight/src/robot.dart';
import 'package:flame/components.dart';

/// A [RobotDriver] is an implementation of some method whereby
/// the player can control a robot. For example,
/// the main one will be backed by a small programming language
/// that allows the user to create a "program" for each
/// turret.
abstract class RobotDriver extends Component with ParentIsA<Robot> {
  /// The number of times the driver is run per second. In other
  /// words, the number of times the user program can change the
  /// robot state per second.
  ///
  /// TODO: Move this to game config
  static const runsPerSec = 1.0;

  double _sinceLastRun = 0.0;

  void run();

  @override
  void update(double dt) {
    _sinceLastRun += dt;
    if (_sinceLastRun >= 1 / runsPerSec) {
      _sinceLastRun = 0.0;
      run();
    }
  }
}

/// The [DummyDriver] does nothing and is used for testing.
class DummyDriver extends RobotDriver {
  @override
  void run() {}
}
