/// Directional shortcuts for working with robots and cells. These
/// may expand over time, so dispatch should use `switch` statements
/// to get the exhaustiveness check.
enum Heading {
  north,
  east,
  south,
  west,
}

/// Relative directions generally used to modify a [Heading].
enum Direction {
  forward,
  right,
  backward,
  left,
}

extension Relative on Heading {
  Heading get forward => this;

  Heading get right => switch (this) {
        Heading.north => Heading.east,
        Heading.east => Heading.south,
        Heading.south => Heading.west,
        Heading.west => Heading.north
      };

  Heading get backward => switch (this) {
        Heading.north => Heading.south,
        Heading.east => Heading.west,
        Heading.south => Heading.north,
        Heading.west => Heading.east
      };

  Heading get left => switch (this) {
        Heading.north => Heading.west,
        Heading.east => Heading.north,
        Heading.south => Heading.east,
        Heading.west => Heading.south
      };

  Heading to(Direction d) => switch (d) {
        Direction.forward => forward,
        Direction.right => right,
        Direction.backward => backward,
        Direction.left => left,
      };
}
