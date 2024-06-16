const std = @import("std");
const ray = @import("raylib.zig");

pub fn main() !void {
    try ray_main();
    try hints();
}

fn ray_main() !void {
    const width = 750;
    const height = 750;
    const FPS=60;
    //const pixelSize=25;
    const title="Conway game of life";
    var bufferData:[height][width]bool =undefined;
    for (0.., bufferData) |y, row| {
        for (0..,row) |x, _| {
            bufferData[y][x]=false;
        }   
    }
    ray.SetConfigFlags(ray.FLAG_MSAA_4X_HINT | ray.FLAG_VSYNC_HINT);
    ray.InitWindow(width, height, title);
    defer ray.CloseWindow();
    ray.SetTargetFPS(FPS);
    //var prng = std.rand.DefaultPrng.init(0);
    //const rand = prng.random();
    bufferData[0][0]=true;    
    while (!ray.WindowShouldClose()) {
        if (ray.IsKeyPressed(ray.KEY_ESCAPE)) ray.CloseWindow();
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(ray.BLACK);
        //draw buffer
        for (0.., bufferData) |y, row| {
            for (0..,row) |x, cell| {
                std.debug.print("{} {} {}\n",.{x,y,cell});
                if (x%2==0){
                    ray.DrawRectangle(@intCast(x),@intCast(y), 25,25, ray.GREEN);
                }  else {
                    ray.DrawRectangle(@intCast(x),@intCast(y), 25,25, ray.BLACK);
                }
            }   
        }
    }
}

fn hints() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("\n⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯\n", .{});
    try stdout.print("Here are some hints:\n", .{});
    try stdout.print("Run `zig build --help` to see all the options\n", .{});
    try stdout.print("Run `zig build -Doptimize=ReleaseSmall` for a small release build\n", .{});
    try stdout.print("Run `zig build -Doptimize=ReleaseSmall -Dstrip=true` for a smaller release build, that strips symbols\n", .{});
    try stdout.print("Run `zig build -Draylib-optimize=ReleaseFast` for a debug build of your application, that uses a fast release of raylib (if you are only debugging your code)\n", .{});

    try bw.flush(); // don't forget to flush!
}
