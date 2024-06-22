# Conway's Game of Life

## Index
- [Demo](#demo)
- [Description](#description)
- [Rules](#rules)
- [Keymap](#keymap)
- [How to run](#how-to-run)
- [How to Build](#how-to-build)
- [Dependencies](#dependencies)
- [References](#references)
### Demo
**INSERT VIDEO**
### Description
Conway's Game of Life is a cellular automaton devised by the mathematician John Horton Conway in 1970. It is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. Despite its simple rules, the Game of Life can produce complex patterns and behaviors.

### Rules

The game is played on a two-dimensional grid of cells. Each cell can be in one of two states: alive or dead.

1. **Birth**: A dead cell with exactly three live neighbors becomes alive in the next generation.
2. **Survival**: A live cell with two or three live neighbors remains alive in the next generation.
3. **Death**: In all other cases, a cell dies or remains dead in the next generation.

These rules create fascinating patterns and structures, from simple still lifes and oscillators to gliders and spaceships that move across the grid.
### Keymap
| Key             | Action                                                                                                  |
|-----------------|---------------------------------------------------------------------------------------------------------|
| `KEY_ESCAPE`    | Closes the window.                                                                                      |
| `KEY_SPACE`     | Toggles the `IsRunning` state.                                                                          |
| `KEY_ENTER`     | When `IsRunning` is true, it clears and initializes the state.                                          |
| `KEY_RIGHT`     | When `IsRunning` is true, increases the FPS (Frames Per Second) by 1, up to a maximum of 60.             |
| `KEY_LEFT`      | When `IsRunning` is true, decreases the FPS by 1, but not below 10.                                     |

### How to run
### How to Build
### Dependencies
### References

- [Wikipedia: Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
- [The Math of Conway's Game of Life](https://www.youtube.com/watch?v=R9Plq-D1gEk) (YouTube video)


