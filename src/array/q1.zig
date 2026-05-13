const std = @import("std");

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "array q1" {
    try std.testing.expect(true);
}
