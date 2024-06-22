const std = @import("std");
const ray = @import("raylib.zig");

fn drawGrid(rows: i32, colums: i32, cellSize: i32) !void {
    const colorRecOff = ray.GRAY;
    //const colorRecOn = ray.GREEN;
    for (0..@intCast(rows)) |y| {
        for (0..@intCast(colums)) |x| {
            const row: i32 = @intCast(y);
            const column: i32 = @intCast(x);
            const color = colorRecOff;
            const posX = row * cellSize;
            const posY = column * cellSize;
            const recSize = cellSize - 1;
            ray.DrawRectangle(posX, posY, recSize, recSize, color);
        }
    }
}
pub fn main() !void {
    const width = 750;
    const height = 750;
    const FPS = 60;
    const pixelSize = 25;
    const title = "Conway game of life";
    const backgroundColor = ray.BLACK;
    const rows = height / pixelSize;
    const colums = width / pixelSize;
    ray.SetConfigFlags(ray.FLAG_MSAA_4X_HINT | ray.FLAG_VSYNC_HINT);
    ray.InitWindow(width, height, title);
    defer ray.CloseWindow();
    ray.SetTargetFPS(FPS);
    while (!ray.WindowShouldClose()) {
        if (ray.IsKeyPressed(ray.KEY_ESCAPE)) ray.CloseWindow();
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(backgroundColor);
        try drawGrid(rows, colums, pixelSize);
    }
}

//try stdout.print("\n⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯\n", .{});
//try stdout.print("Here are some hints:\n", .{});
//try stdout.print("Run `zig build --help` to see all the options\n", .{});
//try stdout.print("Run `zig build -Doptimize=ReleaseSmall` for a small release build\n", .{});
//try stdout.print("Run `zig build -Doptimize=ReleaseSmall -Dstrip=true` for a smaller release build, that strips symbols\n", .{});
//try stdout.print("Run `zig build -Draylib-optimize=ReleaseFast` for a debug build of your application, that uses a fast release of raylib (if you are only debugging your code)\n", .{});
