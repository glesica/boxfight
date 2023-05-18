# Boxfight

## Design Notes

The user programs will operate based on semantic information
about the world around them, not on analog state. For example,
they shouldn't get positions of enemies in the XY plane from the
radar, they should get distances and headings relative to where
the gun is currently aimed, and so on.

### Architecture

There are several classes that form the basic architecture of the
game and provide a way to easily add new mechanics and content.
The key classes are listed here and documented inline within the
source code.

  - `Grid` - a 2D playing field
  - `Cell` - a cell within the grid
  - `Robot` - a single robot within the game world
  - `Sensor` - a filter that exposes game state to the `Driver`
  - `Driver` - the interface to user programs

