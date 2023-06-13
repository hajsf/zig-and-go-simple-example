const std = @import("std");

const def = @import("def.zig");

pub fn main() void {
    const result1 = def.add(2, 3);
    const result2 = def.sub(2, 3);
    std.debug.print("2 + 3 = {}\n2 - 3 = {}\n", .{ result1, result2 });
}
