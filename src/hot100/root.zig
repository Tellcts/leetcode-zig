pub const dp = @import("dp/root.zig");
pub const array = @import("array/root.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
