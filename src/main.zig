const std = @import("std");
const leetcode = @import("leetcode");

pub fn main() !void {
    std.debug.print("{}", .{leetcode.array.q1.add(1, 2)});
    leetcode.array.q1.add(1, 2);
}
