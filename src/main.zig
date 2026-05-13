const std = @import("std");
const leetcode = @import("leetcode");

pub fn main() !void {
    std.debug.print("{}", .{leetcode.hot100.array.q1.add(1, 2)});
    _ = leetcode.hot100.array.q1.add(1, 2);
}
