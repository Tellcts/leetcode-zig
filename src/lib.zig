//! By convention, root.zig is the root source file when making a package.
pub const hot100 = @import("hot100/root.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
