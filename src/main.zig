const std = @import("std");
const ray = @import("raylib.zig");

var FPS: i32 = 15;
const WIDTH = 750;
const HEIGHT = 750;
const PIXEL_SIZE = 8;
const TITLE = "Conway game of life";
const BACKGROUND_COLOR = ray.BLACK;
const COLOR_REC_OFF = ray.BLACK;
const COLOR_REC_ON = ray.YELLOW;
const ROWS: comptime_int = HEIGHT / PIXEL_SIZE;
const COLUMNS: comptime_int = WIDTH / PIXEL_SIZE;
var CELLS: [ROWS][COLUMNS]i32 = undefined;
var IsRunning = true;
fn DrawGrid() !void {
    for (0..@intCast(ROWS)) |y| {
        for (0..@intCast(COLUMNS)) |x| {
            var color = COLOR_REC_OFF;
            const cell_state = CELLS[y][x];
            if (cell_state == 1) {
                color = COLOR_REC_ON;
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
fn GetAliveNeighbours(row: usize, column: usize) i32 {
    var live: i32 = 0;
    const neighbours_offset = [8][2]i32{
        [_]i32{ -1, 0 }, // Directly above
        [_]i32{ 1, 0 }, // Directly below
        [_]i32{ 0, -1 }, // To the left
        [_]i32{ 0, 1 }, // To the right
        [_]i32{ -1, -1 }, // Diagonal upper left
        [_]i32{ -1, 1 }, // Diagonal upper right
        [_]i32{ 1, -1 }, // Diagonal lower left
        [_]i32{ 1, 1 }, // Diagonal lower right
    };
    for (neighbours_offset) |offset| {
        const y: i32 = @intCast(row);
        const x: i32 = @intCast(column);
        const y_offset: i32 = @intCast(offset[0]);
        const x_offset: i32 = @intCast(offset[1]);
        const neighbor_row: usize = @intCast(@mod((y + y_offset + ROWS), ROWS));
        const neighbor_column: usize = @intCast(@mod((x + x_offset + COLUMNS), COLUMNS));
        const neighbor = CELLS[neighbor_row][neighbor_column];
        if (neighbor == 1) {
            live += 1;
        }
    }
    return live;
}
fn UpdateState() !void {
    var CELLS_TEMP = CELLS;
    //RULES:
    //Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    //Any live cell with more than three live neighbours dies, as if by overpopulation.
    //Any live cell with two or three live neighbours lives on to the next generation.
    //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    for (CELLS_TEMP, 0..) |row, row_index| {
        for (0..row.len) |column_index| {
            const alive_neighbours = GetAliveNeighbours(row_index, column_index);
            const cell = CELLS_TEMP[row_index][column_index];
            const isAlive = cell == 1;
            if (isAlive) {
                if (alive_neighbours < 2 or alive_neighbours > 3) {
                    CELLS_TEMP[row_index][column_index] = 0;
                }
                if (alive_neighbours == 2 or alive_neighbours == 3) {
                    CELLS_TEMP[row_index][column_index] = 1;
                }
            } else {
                if (alive_neighbours == 3) {
                    CELLS_TEMP[row_index][column_index] = 1;
                }
            }
        }
    }
    CELLS = CELLS_TEMP;
}
fn InitState() !void {
    var rand_impl = std.rand.DefaultPrng.init(0);
    const prob = @mod(rand_impl.random().int(i8), 100);
    for (0..CELLS.len) |y| {
        for (0..CELLS[y].len) |x| {
            const random = @mod(rand_impl.random().int(i8), 100);
            if (random > prob) {
                CELLS[y][x] = 1;
            }
        }
    }
}
fn ClearState() !void {
    for (0..CELLS.len) |y| {
        for (0..CELLS[y].len) |x| {
            CELLS[y][x] = 0;
        }
    }
}
fn HandleInput() !void {
    if (ray.IsKeyPressed(ray.KEY_ESCAPE)) {
        ray.CloseWindow();
    }
    if (ray.IsKeyPressed(ray.KEY_SPACE)) {
        IsRunning = !IsRunning;
    }
    if (IsRunning) {
        if (ray.IsKeyPressed(ray.KEY_ENTER)) {
            try ClearState();
            try InitState();
        }
        if (ray.IsKeyPressed(ray.KEY_RIGHT) or ray.IsKeyPressedRepeat(ray.KEY_RIGHT)) {
            if (FPS <= 60) {
                FPS += 1;
                ray.SetTargetFPS(FPS);
            }
        }
        if (ray.IsKeyPressed(ray.KEY_LEFT) or ray.IsKeyPressedRepeat(ray.KEY_LEFT)) {
            if (FPS > 10) {
                FPS -= 1;
                ray.SetTargetFPS(FPS);
            }
        }
    }
}
fn RunGame() !void {
    ray.SetTraceLogLevel(ray.LOG_ERROR);
    ray.SetConfigFlags(ray.FLAG_MSAA_4X_HINT | ray.FLAG_VSYNC_HINT);
    ray.InitWindow(WIDTH, HEIGHT, TITLE);
    defer ray.CloseWindow();
    ray.SetTargetFPS(FPS);
    try InitState();
    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(BACKGROUND_COLOR);
        try HandleInput();
        if (IsRunning) {
            try UpdateState();
        }
        try DrawGrid();
        ray.DrawFPS(0, 0);
    }
}
pub fn main() !void {
    try RunGame();
}
