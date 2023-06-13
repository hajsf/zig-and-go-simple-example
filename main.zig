const std = @import("std");

extern fn add(a: i32, b: i32) i32;
extern fn sub(a: i32, b: i32) i32;

pub fn main() void {
    const result1 = add(2, 3);
    const result2 = sub(2, 3);
    std.debug.print("2 + 3 = {}\n2 - 3 = {}\n", .{ result1, result2 });
}
