pub const q1 = @import("q1.zig");
pub const q2 = @import("q2.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
