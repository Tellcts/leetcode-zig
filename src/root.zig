//! By convention, root.zig is the root source file when making a package.
const std = @import("std");
pub const dp = @import("dp/root.zig");
pub const array = @import("array/root.zig");

test {
    std.testing.refAllDecls(@This());
}
