const std = @import("std");
const leetcode = @import("leetcode");

pub fn main() void {
    var x: i32 = undefined;
    var y: i32 = undefined;

    const tuple = .{ 1, 2 };
    x, y = tuple;
    x, y = .{ y, x };
    std.debug.print("{} {}", .{ x, y });
}
