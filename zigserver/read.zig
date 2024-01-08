const std = @import("std");

pub fn main() !void {
    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .{};
    defer _ = gpa.deinit(); // <- this will tell you about memory leaks
    const allocator: std.mem.Allocator = gpa.allocator();

    const contents = try readFile(allocator, "index.html");
    defer allocator.free(contents);

    std.debug.print("File contents: {s}\n", .{contents});
}

pub fn readFile(allocator: std.mem.Allocator, filename: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    const contents = try file.reader().readAllAlloc(allocator, std.math.maxInt(usize));
    errdefer allocator.free(contents);

    return contents;
}