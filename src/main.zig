const std = @import("std");
const ray = @import("raylib.zig");

const WIDTH = 750;
const HEIGHT = 750;
const FPS = 60;
const PIXEL_SIZE = 25;
const TITLE = "Conway game of life";
const BACKGROUND_COLOR = ray.BLACK;
const ROWS = HEIGHT / PIXEL_SIZE;
const COLUMNS = WIDTH / PIXEL_SIZE;
var CELLS: [ROWS][COLUMNS]i32 = undefined;

fn setState(state: bool, row: usize, column: usize) !void {
    if (state) {
        CELLS[row][column] = 1;
    } else {
        CELLS[row][column] = 0;
    }
}

fn drawGrid() !void {
    const colorRecOff = ray.GRAY;
    const colorRecOn = ray.GREEN;
    for (0..@intCast(ROWS)) |y| {
        for (0..@intCast(COLUMNS)) |x| {
            var color = colorRecOff;
            const cell_state = CELLS[y][x];
            if (cell_state == 1) {
                color = colorRecOn;
            }
            const row: i32 = @intCast(y);
            const column: i32 = @intCast(x);
            const posX = row * PIXEL_SIZE;
            const posY = column * PIXEL_SIZE;
            const recSize = PIXEL_SIZE - 1;
            ray.DrawRectangle(posX, posY, recSize, recSize, color);
        }
    }
}
fn updateState() !void {
    //Apply Conway's rules
    //Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    //Any live cell with two or three live neighbours lives on to the next generation.
    //Any live cell with more than three live neighbours dies, as if by overpopulation.
    //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

}
pub fn main() !void {
    ray.SetConfigFlags(ray.FLAG_MSAA_4X_HINT | ray.FLAG_VSYNC_HINT);
    ray.InitWindow(WIDTH, HEIGHT, TITLE);
    defer ray.CloseWindow();
    ray.SetTargetFPS(FPS);
    //try setState(true, ROWS / 2, COLUMNS / 2);
    while (!ray.WindowShouldClose()) {
        if (ray.IsKeyPressed(ray.KEY_ESCAPE)) ray.CloseWindow();
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(BACKGROUND_COLOR);
        try drawGrid();
    }
}

//try stdout.print("\n⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯\n", .{});
//try stdout.print("Here are some hints:\n", .{});
//try stdout.print("Run `zig build --help` to see all the options\n", .{});
//try stdout.print("Run `zig build -Doptimize=ReleaseSmall` for a small release build\n", .{});
//try stdout.print("Run `zig build -Doptimize=ReleaseSmall -Dstrip=true` for a smaller release build, that strips symbols\n", .{});
//try stdout.print("Run `zig build -Draylib-optimize=ReleaseFast` for a debug build of your application, that uses a fast release of raylib (if you are only debugging your code)\n", .{});
